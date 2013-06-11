widget :attending_saturday do
  key "ee40c9ef83ff5b9df334b12e26a3498ae9a7b39b"
  type "number_and_secondary"
  data do
    {
      :value => Interaction.where(:key => 'attending_saturday', :value => 'true', :current => 'true').count(),
    }
  end
end
