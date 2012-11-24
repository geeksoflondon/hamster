namespace :importer do
  namespace :eventbrite do
    desc "Updates all the data for the imported events"
    task :update_added => :environment do
      Importers::EventBrite.new.update_added_events
    end

    desc "List all events on EventBrite"
    task :list => :environment do
      ap Importers::EventBrite.new.events
    end

    desc "Start initial import of an event on EventBrite"
    task :add => :environment do
      Importers::EventBrite.new.add_event
    end
  end
end