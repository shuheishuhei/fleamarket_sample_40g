class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:basic_auth][:user] &&
      password == Rails.application.credentials[:basic_auth][:pass]
    end
  end

  def production?
    Rails.env.production?
  end
end
 