class Zebra::DashboardsController < Zebra::SessionsController

  before_filter :logged_in?, :user, :event, :attendee_status

  def show
    if !params[:nav]
      @tickets = @all
    elsif params[:nav] == "still_expected"
      @tickets = Ticket.find(@still_expected)
    elsif params[:nav] == "saturday_expected"
      @tickets = Ticket.find(@saturday_expected)
    elsif params[:nav] == "sunday_expected"
      @tickets = Ticket.find(@sunday_expected)

    elsif params[:nav] == "arrived"
      @tickets = Ticket.find(@arrived)
    elsif params[:nav] == "saturday_arrived"
      @tickets = Ticket.find(@saturday_arrived)
    elsif params[:nav] == "sunday_arrived"
      @tickets = Ticket.find(@sunday_arrived)

    elsif params[:nav] == "attending"
      @tickets = Ticket.find(@attending)
    elsif params[:nav] == "unconfirmed"
      @tickets = Ticket.find(@unconfirmed)
    elsif params[:nav] == "manually_added"
      @tickets = Ticket.find(@manually_added)
    elsif params[:nav] == "cancelled"
      @tickets = Ticket.find(@cancelled)

    elsif params[:nav] == "onsite"
      @tickets = Ticket.find(@onsite)
    elsif params[:nav] == "offsite"
      @tickets = Ticket.find(@offsite)
    else
      @tickets = []
    end
  end

  def attendee_json
    attendees = []
    event.tickets.includes(:attendee).each do |ticket|
      attendees << {
        'ticket_id' => ticket.id,
        'first_name' => ticket.attendee.first_name,
        'last_name' => ticket.attendee.last_name
      }
    end
    render :json => attendees
    expires_in(1.minutes)
  end

  private

  def attendee_status
    @all = event.tickets.includes(:attendee)

    # Attended
    arrived_interactions = event.arrived_tickets
    @arrived = event.arrived_tickets_ids
    @saturday_arrived = event.arrived_saturday_tickets_ids
    @sunday_arrived = event.arrived_sunday_tickets_ids


    @manually_added = event.manually_added_tickets_ids

    # Confirmation state
    @attending = event.attending_tickets_ids
    @cancelled = event.not_attending_tickets_ids
    @unconfirmed = @all.pluck(:id) - @attending - @cancelled - @manually_added

    # Checkin state
    @onsite = event.onsite_tickets_ids
    @offsite = event.not_onsite_tickets_ids

    # Expected
    @still_expected = @attending - @arrived - @manually_added
    @saturday_expected = event.attending_saturday_tickets_ids
    @sunday_expected = event.attending_sunday_tickets_ids - @arrived - @cancelled
  end

end