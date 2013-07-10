widget :attendees_rag do
  key "7190bd26a4e8030ec979a4650f9d212965282af4"
  type "rag"
  event = Event.find(2)
  total = event.tickets.count
  confirmed = event.confirmed_tickets_ids.count
  cancelled = event.not_attending_tickets_ids.count
  unconfirmed = total - confirmed - cancelled
  data do
    {
      :red => {:label => cancelled, :value => 'Cancelled'},
      :amber => {:label => unconfirmed, :value => 'Unconfirmed'},
      :green => {:label => confirmed, :value => 'Confirmed'}
    }
  end
end
