widget :attending_attendees do
  key "b321eab7e35d8ced53c73afc2632a996f296a56e"
  type "number_and_secondary"
  event = Event.find(2)
  data do
    {
      :value => event.attending_tickets_ids.count
    }
  end
end
