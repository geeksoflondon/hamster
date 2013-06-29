class Zebra::TicketController < Zebra::SessionsController

  before_filter :logged_in?, :user, :event
  before_filter :ticket, :except => [:new, :create]
  
  def show
    @attendee = @ticket.attendee
    @interactions = @ticket.interactions.order('created_at DESC')
    @checkins = Interaction.unscoped.where({key: 'onsite', interactable_type: 'Ticket', interactable_id: @ticket.id}).order('created_at DESC')
  end

  def new
    @ticket = Ticket.new
  end

  def update
    attendee = ticket.attendee
    attendee.first_name = params[:first_name]
    attendee.last_name = params[:last_name]
    attendee.twitter = params[:twitter]
    attendee.notes = params[:notes]
    attendee.save

    @ticket.kind = params[:kind]
    @ticket.save
    flash[:notice] = "#{attendee.name} is now updated"
    redirect_to :zebra_ticket
  end

  def create
      @attendee = Attendee.create({
        first_name: params[:first_name],
        last_name: params[:last_name],
        twitter: params[:twitter],
        email: params[:email]
      })

      @ticket = Ticket.create({
        attendee: @attendee,
        event: @event,
        kind: 1,
        eventbrite_xid: "lastminute_#{params[:first_name]}_#{params[:last_name]}_#{@attendee.id}"
      })
      @ticket.is_manually_added!

    if @ticket.valid? && @attendee.valid?
      redirect_to zebra_ticket_path(@ticket)
      flash[:notice] = "#{@attendee.name} is now created"
    else
      flash[:notice] = "Attendee could not be created"
      render :new
    end
  end

  def checkin
    @ticket.is 'onsite'
    flash[:notice] = "#{@ticket.attendee.name} is now checked in"
    redirect_to "/zebra/ticket/#{@ticket.id}"
  end

  def checkout
    @ticket.isnt 'onsite'
    flash[:notice] = "#{@ticket.attendee.name} is now checked out"
    redirect_to "/zebra/ticket/#{@ticket.id}"
  end
  
  private
  
  def ticket
    params[:id] = params[:ticket_id] if params[:id].nil?
    @ticket = Ticket.find(params[:id])
    unless @ticket.event_id == @event.id
      flash[:error] = "Sorry that ticket does not belong to this event"
      redirect_to "/zebra/dashboard"
    end
  end

end