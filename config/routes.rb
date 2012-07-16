def create_resource_for model, handled = []
  # we dont want to loop the recursion
  handled << model

  # we don't need the new and edit form
  resources model, except: [:new, :edit] do
    # automagically create nested routes for their direct associations,
    # used for active resource relations
    model.to_s.capitalize.singularize.constantize.reflect_on_all_associations.each do |association|
      create_resource_for association.name, handled if handled.exclude?(association.name) && association.macro == :has_many
    end

    # extra action needed for pagination
    collection { get :count }
  end
end

Hamster::Application.routes.draw do
  # create routes for these models
  [:attendees, :emails, :tickets, :interactions, :events].each do |model|
    create_resource_for model
  end
end


