require "net/http"
require "uri"
require 'nokogiri'

class SMSCsiApi
  attr_accessor :client

  def sms_deliver(phone, code)
    prf = "[#{self.class}" + '::sms_deliver] '
    Rails.logger.info "#{prf}sms end poit: #{Rails.application.secrets.sms_end_point}"
    start = Time.zone.now

    uri = URI(Rails.application.secrets.sms_end_point)
    response = Net::HTTP.post_form(uri, 'xmlSms' => request(phone, code))
    finish = Time.zone.now
    Rails.logger.info "#{prf}Risposta del Gateway SMS, response.code: #{response.code}, response.body: #{response.body}, " \
      "tempo di esecuzione: " + (finish - start).to_s + ' sec'

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
end
