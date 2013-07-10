widget :cancelled_attendees do
  key "613933a628c08495ce6132f1b5b434ff68021e4b"
  type "number_and_secondary"
  event = Event.find(2)
  data do
    {
      :value => event.not_attending_tickets_ids.count,
    }
  end
end
