require "net/http"
require "uri"
require 'nokogiri'

class SMSCsiApi
  attr_accessor :client

  def sms_deliver(phone, text)
    prf = "[#{self.class}" + '::sms_deliver] '
    Rails.logger.info "#{prf}sms end poit: #{Rails.application.secrets.sms_end_point}"
    start = Time.zone.now
    res_op = false

    begin
      uri = URI(Rails.application.secrets.sms_end_point)
      response = Net::HTTP.post_form(uri, 'xmlSms' => request(phone, text))

      finish = Time.zone.now
      Rails.logger.info "#{prf}Risposta del Gateway SMS, response.code: #{response.code}, response.body: #{response.body}, " \
        "tempo di esecuzione: " + (finish - start).to_s + ' sec'

      res_op = success?(response.body.to_s)
    rescue Exception => e
      Rails.logger.error "#{prf}Rilevata Exception, dettaglio: #{e.message}"
    end
    res_op
  end

  def request(phone, text)
    prf = "[#{self.class}" + '::request] '
    Rails.logger.info "#{prf}phone: #{phone}, text: #{text}"
    phone_iprefix = "0039#{phone}" # deve iniziare con il prefisso internazionale, per l'Italia '0039'
    Rails.logger.info "#{prf}phone_iprefix: #{phone_iprefix}"

    xml_req = "<RICHIESTA_SMS><USERNAME>#{Rails.application.secrets.sms_username}</USERNAME>" \
    "<PASSWORD>#{Rails.application.secrets.sms_password}</PASSWORD>" \
    "<CODICE_PROGETTO>#{Rails.application.secrets.sms_project_code}</CODICE_PROGETTO>" \
    "<REPLY_DETAIL>none</REPLY_DETAIL><SMS><TELEFONO>#{phone_iprefix}</TELEFONO><TESTO>#{text}</TESTO>" \
    "<CODIFICA/><TTL/><PRIORITA/><DATA_INVIO/><NOTE>-</NOTE></SMS></RICHIESTA_SMS>"
    xml_req
  end

  # response_body nella forma
  # <MESSAGGIO><TITOLO> titolo esito richiesta </TITOLO><DESCRIZIONE> descrizione esito richiesta </DESCRIZIONE></MESSAGGIO>
  def success?(response_body)
    prf = "[#{self.class}" + '::success?] '
    doc = Nokogiri::XML(response_body)
    msg = doc.at_xpath('//MESSAGGIO')
    titolo = msg.at_xpath('//TITOLO').content
    descr = msg.at_xpath('//DESCRIZIONE').content

    if titolo == 'INSERIMENTO SMS' && descr == 'Inserimento effettuato con successo'
      Rails.logger.info "#{prf}#{titolo}: #{descr}"
      res = true
    else
      Rails.logger.error "#{prf}Errore occorso durante la richiesta di invio codice tramite SMS [Titolo: #{titolo}, Descrizione: #{descr}]"
      res = false
    end
    res
  end
end
