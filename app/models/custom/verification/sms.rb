class Verification::Sms
  include ActiveModel::Model

  attr_accessor :user, :phone, :confirmation_code

  validates :phone, presence: true
  validates :phone, format: { with: /\A[\d \+]+\z/ }
  validate :uniqness_phone
  validate :prefix_phone

  def uniqness_phone
    errors.add(:phone, :taken) if User.where(confirmed_phone: phone).any?
  end

  # Verifica che il numero di cellulare introdotto sia della lunghezza corretta
  # Numero di cellulare nel formato: 0039 3XX 123456 (o 1234567) - lunghezza totale 4 + 3 + 6/7 = 13/14
  # Verifica che il numero di cellulare introdotto sia comprensivo del prefisso italiano (0039)
  def prefix_phone
    if phone.length != 13 && phone.length != 14
      errors.add(:phone, :invalid)
      return
    end
    errors.add(:phone, :invalid) unless phone.start_with?('0039')
  end

  def save
    return false unless valid?
    update_user_phone_information
    send_sms
    Lock.increase_tries(user)
  end

  def update_user_phone_information
    user.update(unconfirmed_phone: phone, sms_confirmation_code: generate_confirmation_code)
  end

  def send_sms
    SMSCsiApi.new.sms_deliver(user.unconfirmed_phone, user.sms_confirmation_code)
  end

  def verified?
    user.sms_confirmation_code == confirmation_code
  end

  private

    def generate_confirmation_code
      rand.to_s[2..5]
    end
end
