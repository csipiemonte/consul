class Users::SessionsController < Devise::SessionsController

  private

    def after_sign_in_path_for(resource)
      check_current_user_residence if current_user.document_number

      if !verifying_via_email? && resource.show_welcome_screen?
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
      request.referer.present? ? request.referer : super
    end

    def verifying_via_email?
      return false if resource.blank?
      stored_path = session[stored_location_key_for(resource)] || ""
      stored_path[0..5] == "/email"
    end

end
