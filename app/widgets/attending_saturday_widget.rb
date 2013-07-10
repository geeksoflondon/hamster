widget :attending_saturday do
  key "ee40c9ef83ff5b9df334b12e26a3498ae9a7b39b"
  type "number_and_secondary"
  event = Event.find(2)
  data do
    {
      :value => event.attending_saturday_tickets_ids.count
    }
  end
end
