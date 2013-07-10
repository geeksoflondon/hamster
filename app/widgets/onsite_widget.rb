widget :onsite do
  key "ee3322dbeb1f9fe07b2a224c1b4d7e3e35aae7aa"
  type "geckometer"
  event = Event.find(2)
  arrived = event.arrived_tickets_ids.count
  onsite = event.onsite_tickets_ids.count
  data do
    {
      :value => onsite,
      :min => {:label => '', :value => 0},
      :max => {:label => 'Onsite', :value => onsite}
    }
  end
end
