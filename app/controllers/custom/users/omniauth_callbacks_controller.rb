# Custom Decidi Torino Users::OmniauthCallbacksController
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def twitter
    sign_in_with :twitter_login, :twitter
  end

  def facebook
    sign_in_with :facebook_login, :facebook
  end

  def google_oauth2
    sign_in_with :google_login, :google_oauth2
  end

  def shibboleth
    sign_in_with :shibboleth_login, :shibboleth
  end

  def after_sign_in_path_for(resource)
    if resource.registering_with_oauth
      finish_signup_path
    else
      super(resource)
    end
  end

  private

    def sign_in_with(feature, provider)
      prf = "[#{self.class}" + '::sign_in_with] '
      raise ActionController::RoutingError.new('Not Found') unless Setting["feature.#{feature}"]

      auth = env["omniauth.auth"]
      Rails.logger.info "#{prf}auth: #{auth}"

      identity = Identity.first_or_create_from_oauth(auth)
      @user = current_user || identity.user || User.first_or_initialize_for_oauth(auth)

      if save_user
        identity.update(user: @user)
        sign_in_and_redirect @user, event: :authentication
        kind_msg = provider.to_s.capitalize
        Rails.logger.info "#{prf}provider: #{provider}"

        if provider.to_s == 'shibboleth' # su shibboleth si basa l'autenticazione di molti Identity Provider (SPID, TorinoFacile)
          kind_msg = auth.info.idp
        end

        set_flash_message(:notice, :success, kind: kind_msg) if is_navigational_format?
      else
        session["devise.#{provider}_data"] = auth
        redirect_to new_user_registration_url
      end
    end

    def save_user
      @user.save || @user.save_requiring_finish_signup
    end

end
