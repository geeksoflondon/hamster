widget :attending_sunday do
  key "55b5c5791d0b0bbae22dc75b62583aea3479cf07"
  type "number_and_secondary"
  event = Event.find(2)
  data do
    {
      :value => event.attending_sunday_tickets_ids.count
    }
  end
end
