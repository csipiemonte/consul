# CensusCsiApi, versione custom dell'originale CensusApi, la verifica e' condotta solo sulla base del
# codice fiscale e i WS invocati sono 2
class CensusCsiApi

  def call(cod_fiscale)
    prf = "[#{self.class}" + '::call] '
    Rails.logger.info "#{prf}cod_fiscale: #{cod_fiscale}"

    resp_body = nil
    err_msg = nil
    begin
      resp_body = get_response_body(cod_fiscale)
    rescue Savon::SOAPFault => error
      err_msg = error.message
      Rails.logger.error "#{prf}Rilevato Savon::SOAPFault, dettaglio: #{err_msg}"
    rescue Savon::HTTPError => e
      err_msg = e.message
      Rails.logger.error "#{prf}Rilevato Savon::HTTPError, dettaglio: #{err_msg}"
    rescue Savon::InvalidResponseError => e
      err_msg = e.message
      Rails.logger.error "#{prf}Rilevato Savon::InvalidResponseError, dettaglio: #{err_msg}"
    rescue Net::HTTPFatalError => e
      err_msg = e.message
      Rails.logger.error "#{prf}Rilevato Net::HTTPFatalError, dettaglio: #{err_msg}"
    end

    response = Response.new(resp_body, err_msg)
    response
  end

  class Response

    # Il json della risposta deve essere cosi' composto
    #  {
    #    get_habita_datos_response: {
    #      get_habita_datos_return: {
    #        datos_operacion: 'OK',
    #        datos_habitante: {
    #          item: {
    #            fecha_nacimiento_string: "31-12-1980",
    #            descripcion_sexo: "male", nombre: "Jose", apellido1: "Garcia"
    #          }
    #        },
    #        datos_vivienda: { item: { codigo_postal: "28013", codigo_distrito: "01" } }
    #      }
    #    }
    #  }
    def initialize(resp_body, err_msg)
      prf = "[#{self.class}" + '::initialize] '
      Rails.logger.info "#{prf}resp_body: #{resp_body}, err_msg: #{err_msg}"

      @body = {}
      @body[:get_habita_datos_response] = { get_habita_datos_return: {} }
      @body[:get_habita_datos_response][:get_habita_datos_return] = { datos_operacion: 'OK', datos_habitante: { }, datos_vivienda: { } }

      if err_msg
        datos_op = 'KO'
        datos_op = 'NOT_FOUND' if err_msg.index('it.csi.naosrv.interfaceCSI.exception.SoggettoNotFoundException')
        @body[:get_habita_datos_response][:get_habita_datos_return][:datos_operacion] = datos_op
        return
      end

      @body[:get_habita_datos_response][:get_habita_datos_return][:datos_habitante] = { item: {} }
      @body[:get_habita_datos_response][:get_habita_datos_return][:datos_vivienda] = { item: {} }

      resp_body[:multi_ref].each do |r|
        type = r[:"@xsi:type"].rpartition(':').last
        next if type != 'Generalita' && type != 'StatoSoggetto' && type != 'IndirizzoInterno'
        Rails.logger.debug "#{prf}type: #{type}"

        if type == 'Generalita'
          @body[:get_habita_datos_response][:get_habita_datos_return][:datos_habitante][:item][:nombre] = r[:nome]
          @body[:get_habita_datos_response][:get_habita_datos_return][:datos_habitante][:item][:apellido1] = r[:cognome]
          @body[:get_habita_datos_response][:get_habita_datos_return][:datos_habitante][:item][:descripcion_sexo] = r[:sesso]

          birth_d = r[:data_nascita] # data di nascita dal formato AAAAMMGG al formato GG-MM-AAAA
          format_birth_d = "#{birth_d[6, 2]}-#{birth_d[4, 2]}-#{birth_d[0, 4]}"
          @body[:get_habita_datos_response][:get_habita_datos_return][:datos_habitante][:item][:fecha_nacimiento_string] = format_birth_d
          Rails.logger.info "#{prf}nome: #{r[:nome]}, cognome: #{r[:cognome]}, data_nascita: #{format_birth_d}, sesso: #{r[:sesso]}"

        elsif type == 'StatoSoggetto'
          Rails.logger.info "#{prf}desc_breve_stato: #{r[:desc_breve_stato]}"
          @body[:get_habita_datos_response][:get_habita_datos_return][:datos_habitante][:item][:estado] = r[:desc_breve_stato]

        elsif type == 'IndirizzoInterno'
          Rails.logger.info "#{prf}cap: #{r[:cap]}, id_circoscrizione: #{r[:id_circoscrizione]}, desc_circoscr: #{r[:desc_circoscrizione]}"
          @body[:get_habita_datos_response][:get_habita_datos_return][:datos_vivienda][:item][:codigo_postal] = r[:cap]
          @body[:get_habita_datos_response][:get_habita_datos_return][:datos_vivienda][:item][:codigo_distrito] = r[:id_circoscrizione]
        end
      end

      Rails.logger.info "#{prf}@body: #{@body}"
    end

    def return_code
      data[:datos_operacion]
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

    def status
      data[:datos_habitante][:item][:estado]
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

    start = Time.zone.now
    resp = client.call(:visura_soggetto_per_codice_fiscale, message: req).body
    finish = Time.zone.now
    Rails.logger.info prf + 'Risposta del servizio ' + serv_name + ' ottenuta in ' + (finish - start).to_s + ' sec'
    resp
  end

  def client
    @client = Savon.client(
      wsdl: Rails.application.secrets.naosrv_api_end_point,
      basic_auth: [Rails.application.secrets.naosrv_username, Rails.application.secrets.naosrv_password]
    )
  end
end
