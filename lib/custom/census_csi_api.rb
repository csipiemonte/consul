include DocumentParser
class CensusCsiApi

  def call(document_type, document_number)
    prf = "[#{self.class}" + '::call] '
    Rails.logger.info "#{prf}document_number: #{document_number}"
    response = nil
    get_document_number_variants(document_type, document_number).each do |variant|
      resp_body = get_response_body(document_type, variant)
      resp_naosrv_body = get_response_naosrv_body(variant)

      response = Response.new(resp_body, resp_naosrv_body)

      return response if response.valid?
    end
    response
  end

  class Response
    def initialize(body, naosrv_body = nil)
      prf = "[#{self.class}" + '::initialize] '
      Rails.logger.info "#{prf}body: #{body}, naosrv_body: #{naosrv_body}"

=begin
    Il json della risposta deve essere cosi' composto
      {
        get_habita_datos_response: {
          get_habita_datos_return: {
            datos_habitante: {
              item: {
                fecha_nacimiento_string: "31-12-1980",
                identificador_documento: "12345678Z",
                descripcion_sexo: "Varón",
                nombre: "José",
                apellido1: "García"
              }
            },
            datos_vivienda: {
              item: {
                codigo_postal: "28013",
                codigo_distrito: "01"
              }
            }
          }
        }
      }
=end
      upd_body = {}
      upd_body[:get_habita_datos_response] = { :get_habita_datos_return => {} }
      upd_body[:get_habita_datos_response][:get_habita_datos_return] = { :datos_habitante => { }, :datos_vivienda => { } }

      if body.class != Hash || !body.key?(:multi_ref) || naosrv_body.class != Hash || !naosrv_body.key?(:multi_ref)
        Rails.logger.error prf + 'Risposta dei WS non valida'
        @body = upd_body
        return
      end

      upd_body[:get_habita_datos_response][:get_habita_datos_return][:datos_habitante] = { :item => {} }
      upd_body[:get_habita_datos_response][:get_habita_datos_return][:datos_vivienda] = { :item => {} }
      upd_body[:get_habita_datos_response][:get_habita_datos_return][:datos_habitante][:item] = {}
      upd_body[:get_habita_datos_response][:get_habita_datos_return][:datos_vivienda][:item] = {}

      upd_body[:get_habita_datos_response][:get_habita_datos_return][:datos_vivienda][:item][:codigo_distrito] = '01' # TODO, provv

      body[:multi_ref].each do |r|
        type = r[:"@xsi:type"].rpartition(':').last
        Rails.logger.debug "#{prf}type: #{type}"

        if type == 'Cittadino'
          upd_body[:get_habita_datos_response][:get_habita_datos_return][:datos_habitante][:item][:fecha_nacimiento_string] = r[:data_nascita]
          upd_body[:get_habita_datos_response][:get_habita_datos_return][:datos_habitante][:item][:nombre] = r[:nome]
          upd_body[:get_habita_datos_response][:get_habita_datos_return][:datos_habitante][:item][:apellido1] = r[:cognome]
          upd_body[:get_habita_datos_response][:get_habita_datos_return][:datos_habitante][:item][:descripcion_sexo] = r[:sesso]
        elsif type == 'ResidAnag'
          upd_body[:get_habita_datos_response][:get_habita_datos_return][:datos_vivienda][:item][:codigo_postal] = r[:cap]
        elsif type == 'Ci'
          upd_body[:get_habita_datos_response][:get_habita_datos_return][:datos_habitante][:item][:identificador_documento] = r[:numero_ci]
        end
      end

      naosrv_body[:multi_ref].each do |r|
        type = r[:"@xsi:type"].rpartition(':').last
        Rails.logger.debug "#{prf}type: #{type}"

        next if type != 'IndirizzoInterno'
        Rails.logger.info "#{prf}id_circoscrizione: #{r[:id_circoscrizione]}, desc_circoscrizione: #{r[:desc_circoscrizione]}"
        upd_body[:get_habita_datos_response][:get_habita_datos_return][:datos_vivienda][:item][:codigo_distrito] = r[:id_circoscrizione]
        break
      end

      Rails.logger.info "#{prf}upd_body: #{upd_body}"
      @body = upd_body
      Rails.logger.info "#{prf}data: #{data}"
    end

    def valid?
      data[:datos_habitante][:item].present?
    end

    def date_of_birth
      prf = "[#{self.class}" + '::date_of_birth] '
      Rails.logger.info "#{prf}data (date_of_birth): #{data}"
      str = data[:datos_habitante][:item][:fecha_nacimiento_string]
      Rails.logger.info "#{prf}str: #{str}"
      day, month, year = str.match(/(\d\d?)\D(\d\d?)\D(\d\d\d?\d?)/)[1..3]
      Rails.logger.info "#{prf}day: #{day}, month: #{month}, year: #{year}"
      return nil unless day.present? && month.present? && year.present?
      Date.new(year.to_i, month.to_i, day.to_i)
    end

    def postal_code
      data[:datos_vivienda][:item][:codigo_postal]
    end

    def district_code
      data[:datos_vivienda][:item][:codigo_distrito]
    end

    def gender
      case data[:datos_habitante][:item][:descripcion_sexo]
      when 'M'
        'male'
      when "F"
        'female'
      end
    end

    def name
      "#{data[:datos_habitante][:item][:nombre]} #{data[:datos_habitante][:item][:apellido1]}"
    end

    private

      def data
        @body[:get_habita_datos_response][:get_habita_datos_return]
      end
  end # fine class Response

  private

  def get_response_body(document_type, document_number)
    prf = "[#{self.class}" + '::get_response_body] '
    serv_name = '[BPRCSI:TrovaCittadinoDettaglio]'
    begin
      start = Time.zone.now
      client.call(:trova_cittadino_dettaglio, message: request(document_type, document_number)).body
      finish = Time.zone.now
      Rails.logger.info prf + 'Risposta del servizio ' + serv_name + ' ottenuta in ' + (finish - start).to_s + ' sec'
    rescue Savon::SOAPFault => error
      Rails.logger.error "#{prf}Rilevato Savon::SOAPFault, dettaglio: #{error.message}"
    rescue Net::HTTPFatalError => e
      Rails.logger.error "#{prf}Rilevato Net::HTTPFatalError, dettaglio: #{e.message}"
    end
  end

  def get_response_naosrv_body(codice_fiscale)
    prf = "[#{self.class}" + '::get_response_naosrv_body] '
    serv_name = '[NAO::SrvVisuraAnagrafica:VisuraSoggettoPerCodiceFiscale]'
    begin
      start = Time.zone.now
      client_naosrv.call(:visura_soggetto_per_codice_fiscale, message: request_naosrv(codice_fiscale)).body
      finish = Time.zone.now
      Rails.logger.info prf + 'Risposta del servizio ' + serv_name + ' ottenuta in ' + (finish - start).to_s + ' sec'
    rescue Savon::SOAPFault => error
      Rails.logger.error "#{prf}Rilevato Savon::SOAPFault, dettaglio: #{error.message}"
    rescue Net::HTTPFatalError => e
      Rails.logger.error "#{prf}Rilevato Net::HTTPFatalError, dettaglio: #{e.message}"
    end
  end

  def client
    @client = Savon.client(wsdl: Rails.application.secrets.census_api_end_point)
  end

  def client_naosrv
    @client_naosrv = Savon.client(
      wsdl: Rails.application.secrets.naosrv_api_end_point,
      basic_auth: [Rails.application.secrets.naosrv_username, Rails.application.secrets.naosrv_password]
    )
  end

  def request(document_type, document_number)
    req = { }
    if codice_fiscale?(document_type)
      req = { in0: 'TOFA#' + document_number, in1: '1', in2: '0', in3: '0', in4: document_number, in5: '001272' }
    end
    req
  end

  def request_naosrv(codice_fiscale)
    prf = "[#{self.class}" + '::request_naosrv] '
    Rails.logger.info "#{prf}codice_fiscale: #{codice_fiscale}"
    req_in1 = {
      flg_paternita_maternita: false,
      flg_protocolli_riservati_e: false,
      flg_protocolli_riservati_q: false,
      flg_rettifiche_generalita: false,
      flg_soggetti_cancellati: false
    }

    req_in2 = { codice_utente: Rails.application.secrets.naosrv_username }

    req = { in0: codice_fiscale, in1: req_in1, in2: req_in2 }
    Rails.logger.info "#{prf}req: #{req}"
    req
  end

  def dni?(document_type)
    document_type.to_s == '1'
  end

  def codice_fiscale?(document_type)
    document_type.to_s == '4'
  end
end
