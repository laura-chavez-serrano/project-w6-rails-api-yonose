class ApplicationController < ActionController::API 

  include ActionController::HttpAuthentication::Token::ControllerMethods
  # include ActionController::HttpAuthentication::Basic::ControllerMethods

  before_action :verify_authentication
  # before_action :authenticate

  # def authenticate
  #   authenticate_or_request_with_http_basic do |username, password|
  #     username == "amy" && password == "password"
  #   end
  # end

  helper_method :current_user

  protected 
    def current_user
      return unless session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end

  def verify_authentication
    user = authenticate_with_http_token do |token, options|
      User.find_by_api_token(token)
    end

    unless user
      render json: { error: " FUERA! ACCESS DENIED" }, status: :unauthorized
    end
  end

end
