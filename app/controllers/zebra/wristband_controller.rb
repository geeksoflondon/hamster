class Zebra::WristbandController < Zebra::SessionsController
  
  # Notes for everyone (this controller sucks)
  # Am using params[:id] incorrectly it is not the wristband's but the ticket_id
  
  #New Registrations hit #show then > #update
  #Swapouts hit #edit
  
  
  before_filter :logged_in?, :user, :event, :ticket
  
  def show
  end
  
  def edit
    
  end
  
  def update
    #First Arrival?
    unless @ticket.has_arrived?
      @ticket.is_arrived!
      @ticket.is_onsite!
    end

    begin
      Wristband.create(@ticket, params[:wristband])
      flash[:notice] = "Wristband update!"
      redirect_to :zebra_ticket
    rescue Exception => e 
      flash[:error] = e.message
      redirect_to :zebra_wristband
    end
  end
  
  private

  def ticket
    @ticket = Ticket.find(params[:id])
    @attendee = @ticket.attendee
  end
  
end