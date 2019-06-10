# Custom Decidi Torino Users::SessionsController, differisce per la verifca della residenza in caso di utenza
# certificata (check_current_user_residence) e per la chiusura della sessione SPID (after_sign_out_path_for).
class Users::SessionsController < Devise::SessionsController
  before_action :verify_signed_out_user, only: :destroy

  private

    def after_sign_in_path_for(resource)
      if Rails.application.config.verify_residence_on_login
        check_current_user_residence if current_user.document_number
      end

      if current_user.poll_officer?
        new_officing_booth_path
      elsif !verifying_via_email? && resource.show_welcome_screen?
        welcome_path
      else
        super
      end
    end

    def check_current_user_residence
      Rails.logger.info "check_current_user_residence - current_user.document_number: #{current_user.document_number}"

      census_api_resp = CensusCsiApi.new.call(current_user.document_number)
      if census_api_resp.return_code == 'OK'
        Rails.logger.info "check_current_user_residence - current_user.geozone_id: #{current_user.geozone_id}, " \
        "census_api_resp.district_code: #{census_api_resp.district_code}"

        return if current_user.geozone_id.nil? || census_api_resp.district_code.nil?

        if current_user.geozone_id.to_i != census_api_resp.district_code.to_i
          current_user.update(geozone_id: census_api_resp.district_code)
          flash[:notice] = t('devise.sessions.census_code_updated')
        end

      elsif census_api_resp.return_code == 'NOT_FOUND'
        current_user.update(
          sms_confirmation_code: nil,
          document_number: nil,
          document_type: nil,
          residence_verified_at: nil,
          verified_at: nil,
          unconfirmed_phone: nil,
          confirmed_phone: nil,
          letter_requested_at: nil,
          confirmed_hide_at: nil,
          letter_verification_code: nil,
          level_two_verified_at: nil,
          geozone_id: nil,
          gender: nil,
          date_of_birth: nil
        )
        flash[:notice] = t('devise.sessions.user_not_resident')
      end
    end

    def after_sign_out_path_for(resource)
      return Rails.application.config.spid_logout_url if @idp.present? && @idp.provider == 'shibboleth'
      request.referer.present? && !request.referer.match("management") ? request.referer : super
    end

    def verify_signed_out_user
      @idp = Identity.where(user_id: current_user.id).first
    end

    def verifying_via_email?
      return false if resource.blank?
      stored_path = session[stored_location_key_for(resource)] || ""
      stored_path[0..5] == "/email"
    end
end
