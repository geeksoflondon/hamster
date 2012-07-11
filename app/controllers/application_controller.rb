class ApplicationController < ActionController::Base
  protect_from_forgery
  http_basic_authenticate_with :name => Hamster::Config.get(:user), :password => Hamster::Config.get(:password)
end
