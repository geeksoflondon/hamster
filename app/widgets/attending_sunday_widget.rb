widget :attending_sunday do
  key "55b5c5791d0b0bbae22dc75b62583aea3479cf07"
  type "number_and_secondary"
  data do
    {
      :value => Interaction.where(:key => 'attending_sunday', :value => 'true', :current => 'true').count(),
    }
  end
end
