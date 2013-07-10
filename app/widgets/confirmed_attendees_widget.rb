widget :confirmed_attendees do
  key "faa94ed774e65f08239b1f7e2dc04b4eef4043f9"
  type "number_and_secondary"
  event = Event.find(2)
  data do
    {
      :value => event.confirmed_tickets_ids.count,
    }
  end
end
