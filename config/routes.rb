Hamster::Application.routes.draw do
  [:attendees, :emails].each do |model|
    resources model, except: [:new, :edit] do
      collection do
        get :count
      end
    end
  end
end
