def authenticate
  request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Basic.encode_credentials(Hamster::Config.get(:user), Hamster::Config.get(:password))
end