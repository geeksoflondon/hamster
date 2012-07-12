Hamster::Application.routes.draw do
  [:attendees, :emails, :tickets].each do |model|
    resources model, except: [:new, :edit] do
      collection do
        get :count
      end
    end
  end
end
