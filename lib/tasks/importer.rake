require 'colorize'

namespace :importer do
  namespace :event_brite do
    desc "Updates all the data for the imported events"
    task :update_added => :environment do
      # Importers::Eventbrite.new.update_added_events
    end

    desc "List all events on EventBrite"
    task :list => :environment do
      Importers::Eventbrite.new.events.map do |event|
        print "#{event.id}".yellow
        print " - #{event.title} - "
        print event.imported? ? "imported".yellow : "new".green
        print "\n"
      end
    end

    desc "Start initial import of an event on EventBrite"
    task :add => :environment do
      # Importers::Eventbrite.new.add_event
    end
  end
end