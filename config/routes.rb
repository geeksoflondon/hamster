Hamster::Application.routes.draw do
  resources :attendees, except: [:new, :edit] do
    collection do
      get :count
    end
  end
end
