class Zebra::DashboardController < Zebra::SessionsController
  
  before_filter :logged_in?, :user, :event
  
  def index
  end
  
end