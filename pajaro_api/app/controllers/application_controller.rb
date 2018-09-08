class ApplicationController < ActionController::API 

  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate_token

  def authenticate_token
  
      user = authenticate_with_http_token do |api_token, options|
          User.find_by_api_token(token)
          
        end
    
        unless user
          render json: { error: "Access Denied" }, status: :unauthorized
        end
  end

end
