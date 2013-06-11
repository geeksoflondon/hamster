widget :cancelled_attendees do
  key "613933a628c08495ce6132f1b5b434ff68021e4b"
  type "number_and_secondary"
  data do
    {
      :value => Interaction.where(:key => 'attending', :value => 'false', :current => 'true').count(),
    }
  end
end
