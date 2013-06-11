widget :attending_overnight do
  key "7b76bc8333081b85cc2de91666cefdc4a94a4d17"
  type "number_and_secondary"
  data do
    {
      :value => Interaction.where(:key => 'attending_overnight', :value => 'true', :current => 'true').count(),
    }
  end
end
