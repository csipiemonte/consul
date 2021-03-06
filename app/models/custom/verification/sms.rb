class Verification::Sms
  include ActiveModel::Model

  attr_accessor :user, :phone, :confirmation_code

  validates :phone, presence: true
  validates :phone, format: { with: /\A[\d \+]+\z/ }
  validate :uniqness_phone
  validate :prefix_phone

  def uniqness_phone
    return if errors.any?
    errors.add(:phone, :taken) if User.where(confirmed_phone: phone).any?
  end

  # Verifica che il numero di cellulare introdotto sia della lunghezza corretta
  # Numero di cellulare nel formato: 3XX 123456 (o 1234567) - lunghezza totale 3 + 6/7 = 9/10
  def prefix_phone
    return if errors.any?
    if phone.length != 9 && phone.length != 10
      errors.add(:phone, :invalid)
      return
    end
  end

  def save
    return false unless valid?
    update_user_phone_information

    unless (send_sms)
      user.update(unconfirmed_phone: nil, sms_confirmation_code: nil)
      errors.add(:phone, :sms_deliver)
      return false
    end
    Lock.increase_tries(user) # incremento il numero di tentativi qualora non si siano verificati errori con il Gateway SMS
  end

  def update_user_phone_information
    user.update(unconfirmed_phone: phone, sms_confirmation_code: generate_confirmation_code)
  end

  def send_sms
    txt_sms = I18n.t('verification.sms.read.verification_code') + "#{user.sms_confirmation_code}"
    SMSCsiApi.new.sms_deliver(user.unconfirmed_phone, txt_sms)
  end

  def verified?
    user.sms_confirmation_code == confirmation_code
  end

  private

    def generate_confirmation_code
      rand.to_s[2..5]
    end
end
