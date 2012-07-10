Hamster::Application.routes.draw do
  resources :attendees, except: [:new, :edit]
end
