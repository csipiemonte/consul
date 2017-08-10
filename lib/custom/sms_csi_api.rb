require "net/http"
require "uri"
require 'nokogiri'

class SMSCsiApi
  attr_accessor :client

  def sms_deliver(phone, code)
    Rails.logger.info "sms end poit: #{Rails.application.secrets.sms_end_point}"

    uri = URI(Rails.application.secrets.sms_end_point)
    response = Net::HTTP.post_form(uri, 'xmlSms' => request(phone, code))
    Rails.logger.info "response.code: #{response.code}, response.body: #{response.body}"

    success?(response.body.to_s)
  end

  # phone: deve iniziare con il prefisso internazionale (per l'Italia sono ammessi sia '39' sia '0039'
  def request(phone, code)
    Rails.logger.info "phone: #{phone}, code: #{code}"

    xml_req = "<RICHIESTA_SMS><USERNAME>#{Rails.application.secrets.sms_username}</USERNAME>" \
    "<PASSWORD>#{Rails.application.secrets.sms_password}</PASSWORD>" \
    "<CODICE_PROGETTO>#{Rails.application.secrets.sms_project_code}</CODICE_PROGETTO>" \
    "<REPLY_DETAIL>none</REPLY_DETAIL>" \
    "<SMS><TELEFONO>#{phone}</TELEFONO><TESTO>Clave para verificarte: #{code}. Gobierno Abierto</TESTO>" \
    "<CODIFICA/><TTL/><PRIORITA/><DATA_INVIO/><NOTE>-</NOTE></SMS></RICHIESTA_SMS>"
    xml_req
  end

  # response_body nella forma
  # <MESSAGGIO><TITOLO> titolo esito richiesta </TITOLO><DESCRIZIONE> descrizione esito richiesta </DESCRIZIONE></MESSAGGIO>
  def success?(response_body)
    doc = Nokogiri::XML(response_body)
    msg = doc.at_xpath('//MESSAGGIO')
    titolo = msg.at_xpath('//TITOLO').content
    descr = msg.at_xpath('//DESCRIZIONE').content

    titolo == 'INSERIMENTO SMS' && descr == 'Inserimento effettuato con successo'
  end

=begin
  def stubbed_response
    {
      respuesta_sms: {
        identificador_mensaje: "1234567",
        fecha_respuesta: "Thu, 20 Aug 2015 16:28:05 +0200",
        respuesta_pasarela: {
          codigo_pasarela: "0000",
          descripcion_pasarela: "Operación ejecutada correctamente."
        },
        respuesta_servicio_externo: {
          codigo_respuesta: "1000",
          texto_respuesta: "Success"
        }
      }
    }
  end
=end
end
