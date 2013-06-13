class Zebra::TicketController < Zebra::SessionsController
  
  before_filter :logged_in?, :user, :event
  
  def show
    @ticket = Ticket.find(params[:id])
    @attendee = @ticket.attendee
  end
  
  def update
    ticket = Ticket.find(params[:id])
    attendee = ticket.attendee
    attendee.first_name = params[:first_name]
    attendee.last_name = params[:last_name]
    attendee.twitter = params[:twitter]
    attendee.notes = params[:notes]
    attendee.save

    ticket.kind = params[:kind]
    ticket.save
    
    redirect_to :zebra_ticket
  end
  
  def checkin
    ticket = Ticket.find(params[:ticket_id])
    ticket.is 'onsite'
    flash[:notice] = "#{ticket.attendee.name} is now checked in"
    redirect_to "/zebra/ticket/#{ticket.id}"
  end
  
  def checkout
    ticket = Ticket.find(params[:ticket_id])
    ticket.isnt 'onsite'
    flash[:notice] = "#{ticket.attendee.name} is now checked out"
    redirect_to "/zebra/ticket/#{ticket.id}"
  end
  
end