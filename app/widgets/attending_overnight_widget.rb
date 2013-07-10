widget :attending_overnight do
  key "7b76bc8333081b85cc2de91666cefdc4a94a4d17"
  type "number_and_secondary"
  event = Event.find(2)
  data do
    {
      :value => event.attending_overnight_tickets_ids.count
    }
  end
end
