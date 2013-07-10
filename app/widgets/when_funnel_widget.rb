widget :when_funnel do
  key "3f26b21a9cf42a7dcfaab94f602aca30f62dc020"
  type "funnel"
  event = Event.find(2)
  total = event.tickets.count
  confirmed = event.confirmed_tickets_ids.count
  saturday = event.attending_saturday_tickets_ids.count
  sunday = event.attending_sunday_tickets_ids.count
  overnight = event.attending_overnight_tickets_ids.count
  data do
    {
      :hide_percentage => true,
      :items => [
        {:value => confirmed, :label => 'Confirmed Attending'},
        {:value => saturday, :label => 'Saturday'},
        {:value => overnight, :label => 'Overnight'},
        {:value => sunday, :label => 'Sunday'}
      ],
    }
  end
end
