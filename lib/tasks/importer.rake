require 'colorize'
require "importers/eventbrite"

namespace :importer do
  namespace :eventbrite do
    desc "Updates all the data for the imported events"
    task :update_events => :environment do
      Importers::Eventbrite.new.update_added_events
      puts "All events updated"
    end

    desc "List all events on EventBrite"
    task :list_events => :environment do
      Importers::Eventbrite.new.events.each do |event|
        print "#{event.id}".yellow
        print " - #{event.title} - "
        print event.imported? ? "imported".yellow : "new".green
        print "\n"
      end
    end

    desc "Start initial import of an event (including attendees and tickets) on EventBrite"
    task :import_event => :environment do
      importer = Importers::Eventbrite.new
      events = importer.events
      events.each_with_index do |event, index|
        next if event.imported?
        print "(#{index+1})".green
        print " - #{event.title}"
        print "\n"
      end
      print "\n"
      selected_event = nil
      while selected_event.nil?
        print "Choose event to import (1-#{events.size}): "
        input = $stdin.gets
        begin
          selected_event = events[Integer(input)-1]
        rescue ArgumentError => ex
          selected_event = nil
        end
      end

      selected_event.import
      importer.import_attendees selected_event.id
    end

  end
end