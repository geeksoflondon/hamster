class Zebra::DashboardsController < Zebra::SessionsController

  before_filter :logged_in?, :user, :event, :attendee_status

  def show
  	if params[:search]
  		@tickets = event.attendees.where('lower(first_name) LIKE ? or lower(last_name) like ?', "%#{params[:search]}%", "%#{params[:search]}%").map{|a|a.tickets.last}
  	elsif !params[:nav]
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

  private

  def attendee_status
    @all = @event.tickets

    # Attended
    arrived_interactions = Interaction.where(key: "arrived", value: true.to_json, current: true)
    @arrived = arrived_interactions.pluck(:interactable_id)
    @saturday_arrived = arrived_interactions.inject([]){|v,k| k.created_at.saturday? ? v << k.interactable_id : v}
    @sunday_arrived = arrived_interactions.inject([]){|v,k| k.created_at.sunday? ? v << k.interactable_id : v}

    @manually_added = Interaction.where(key: "manually_added", value: true.to_json, current: true).pluck(:interactable_id)

    # Confirmation state
    @attending = Interaction.where(key: "attending", value: true.to_json, current: true).pluck(:interactable_id)
    @cancelled = Interaction.where(key: "attending", value: false.to_json, current: true).pluck(:interactable_id)
    @unconfirmed = @all.pluck(:id) - @attending - @cancelled - @manually_added

    # Checkin state
    @onsite = Interaction.where(key: "onsite", value: true.to_json, current: true).pluck(:interactable_id)
    @offsite = Interaction.where(key: "onsite", value: false.to_json, current: true).pluck(:interactable_id)

    # Expected
    @still_expected = @attending - @arrived - @manually_added
    @saturday_expected = Interaction.where(key: "attending_saturday", value: true.to_json, current: true).pluck(:interactable_id) - @arrived - @cancelled
    @sunday_expected = Interaction.where(key: "attending_sunday", value: true.to_json, current: true).pluck(:interactable_id) - @arrived - @cancelled


  end

end