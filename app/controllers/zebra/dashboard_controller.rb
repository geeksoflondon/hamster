class Zebra::DashboardController < Zebra::SessionsController
  
  before_filter :logged_in?, :attendee, :event
  
  def index
  end
  
end