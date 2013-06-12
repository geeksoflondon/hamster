class Zebra::DashboardController < Zebra::SessionsController
  
  before_filter :logged_in?
  
  def index
  end
  
end