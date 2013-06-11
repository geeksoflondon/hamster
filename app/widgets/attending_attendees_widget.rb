widget :attending_attendees do
  key "b321eab7e35d8ced53c73afc2632a996f296a56e"
  type "number_and_secondary"
  data do
    {
      :value => Interaction.where(:key => 'attending', :value => 'true', :current => 'true').count(),
    }
  end
end
