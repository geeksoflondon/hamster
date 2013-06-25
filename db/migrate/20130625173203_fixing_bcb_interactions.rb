class FixingBcbInteractions < ActiveRecord::Migration
  def up
    #Get the BarCamp Berkshire Ticket ids which arrived
    event = Event.find(1)
    ticket = event.arrived_tickets

    ticket.each do |ticket|
      interactions = Interaction.unscoped.where({key: 'onsite', interactable_type: 'Ticket', interactable_id: ticket.id})

      interactions.each do |interaction|
        ticket.is_arrived_saturday! if interaction[:created_at].saturday?
        ticket.is_arrived_sunday! if interaction[:created_at].sunday?
      end

    end
  end
end
