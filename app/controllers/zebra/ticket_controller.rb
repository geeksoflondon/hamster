class Zebra::TicketController < Zebra::SessionsController

  before_filter :logged_in?, :user, :event

  def show
    @ticket = Ticket.find(params[:id])
    @attendee = @ticket.attendee
    @interactions = @ticket.interactions.order('created_at DESC')
    @checkins = Interaction.unscoped.where({key: 'onsite', interactable_type: 'Ticket', interactable_id: @ticket.id}).order('created_at DESC')
  end

  def new
    @ticket = Ticket.new
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
        eventbrite_xid: "lastminute #{params[:first_name]} #{params[:last_name]} #{@attendee.id}"
      })
      @ticket.has "manually_added", true

    if @ticket.valid? && @attendee.valid?
      redirect_to zebra_ticket_path(@ticket)
      flash[:notice] = "#{@attendee.name} is now created"
    else
      flash[:notice] = "Attendee could not be created"
      render :new
    end
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