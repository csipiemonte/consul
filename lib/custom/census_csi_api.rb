# CensusCsiApi, versione custom dell'originale CensusApi, la verifica e' condotta solo sulla base del
# codice fiscale e i WS invocati sono 2
class CensusCsiApi

  def call(cod_fiscale)
    prf = "[#{self.class}" + '::call] '
    Rails.logger.info "#{prf}cod_fiscale: #{cod_fiscale}"
    body = get_response_body(cod_fiscale)
    response = Response.new(body)
    response
  end

  class Response
    def initialize(body)
      prf = "[#{self.class}" + '::initialize] '
      Rails.logger.info "#{prf}body: #{body}"

=begin
    Il json della risposta deve essere cosi' composto
      {
        get_habita_datos_response: {
          get_habita_datos_return: {
            datos_habitante: {
              item: {
                fecha_nacimiento_string: "31-12-1980",
                descripcion_sexo: "Varón", nombre: "José", apellido1: "García"
              }
            },
            datos_vivienda: { item: { codigo_postal: "28013", codigo_distrito: "01" } }
          }
        }
      }
=end
      upd_body = {}
      upd_body[:get_habita_datos_response] = { :get_habita_datos_return => {} }
      upd_body[:get_habita_datos_response][:get_habita_datos_return] = { :datos_habitante => { }, :datos_vivienda => { } }

      if body.class != Hash || !body.key?(:multi_ref)
        Rails.logger.error prf + 'Risposta dei WS non valida'
        @body = upd_body
        return
      end

      upd_body[:get_habita_datos_response][:get_habita_datos_return][:datos_habitante] = { :item => {} }
      upd_body[:get_habita_datos_response][:get_habita_datos_return][:datos_vivienda] = { :item => {} }
      upd_body[:get_habita_datos_response][:get_habita_datos_return][:datos_habitante][:item] = {}
      upd_body[:get_habita_datos_response][:get_habita_datos_return][:datos_vivienda][:item] = {}

      body[:multi_ref].each do |r|
        type = r[:"@xsi:type"].rpartition(':').last
        next if type != 'Generalita' && type != 'IndirizzoInterno'
        Rails.logger.debug "#{prf}type: #{type}"

        if type == 'Generalita'
          upd_body[:get_habita_datos_response][:get_habita_datos_return][:datos_habitante][:item][:nombre] = r[:nome]
          upd_body[:get_habita_datos_response][:get_habita_datos_return][:datos_habitante][:item][:apellido1] = r[:cognome]
          birth_d = r[:data_nascita] # data di nascita dal formato AAAAMMGG al formato GG-MM-AAAA
          formatted_birth_d = "#{birth_d[6,2]}-#{birth_d[4,2]}-#{birth_d[0,4]}"
          upd_body[:get_habita_datos_response][:get_habita_datos_return][:datos_habitante][:item][:fecha_nacimiento_string] = formatted_birth_d
          upd_body[:get_habita_datos_response][:get_habita_datos_return][:datos_habitante][:item][:descripcion_sexo] = r[:sesso]

          Rails.logger.info "#{prf}nome: #{r[:nome]}, cognome: #{r[:cognome]}, data_nascita: #{formatted_birth_d}, sesso: #{r[:sesso]}"

        elsif type == 'IndirizzoInterno'
          Rails.logger.info "#{prf}cap: #{r[:cap]}, id_circoscrizione: #{r[:id_circoscrizione]}, desc_circoscrizione: #{r[:desc_circoscrizione]}"
          upd_body[:get_habita_datos_response][:get_habita_datos_return][:datos_vivienda][:item][:codigo_postal] = r[:cap]
          upd_body[:get_habita_datos_response][:get_habita_datos_return][:datos_vivienda][:item][:codigo_distrito] = r[:id_circoscrizione]
        end
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

  def get_response_body(codice_fiscale)
    prf = "[#{self.class}" + '::get_response_body] '
    serv_name = '[NAO::SrvVisuraAnagrafica:VisuraSoggettoPerCodiceFiscale]'

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
    resp = nil

    begin
      start = Time.zone.now
      resp = client.call(:visura_soggetto_per_codice_fiscale, message: req).body
      finish = Time.zone.now
      Rails.logger.info prf + 'Risposta del servizio ' + serv_name + ' ottenuta in ' + (finish - start).to_s + ' sec'

    rescue Savon::SOAPFault => error
      Rails.logger.error "#{prf}Rilevato Savon::SOAPFault, dettaglio: #{error.message}"
    rescue Savon::HTTPError => e
      Rails.logger.error "#{prf}Rilevato Savon::HTTPError, dettaglio: #{e.message}"
    rescue Savon::InvalidResponseError => e
      Rails.logger.error "#{prf}Rilevato Savon::InvalidResponseError, dettaglio: #{e.message}"
    rescue Net::HTTPFatalError => e
      Rails.logger.error "#{prf}Rilevato Net::HTTPFatalError, dettaglio: #{e.message}"
    end
    resp
  end

  def client
    @client = Savon.client(
      wsdl: Rails.application.secrets.naosrv_api_end_point,
      basic_auth: [Rails.application.secrets.naosrv_username, Rails.application.secrets.naosrv_password]
    )
  end
end
