require 'eventbrite-client'
require 'importers/eventbrite/configuration'
require 'importers/eventbrite/event'
require 'importers/eventbrite/venue'
require 'importers/eventbrite/attendee'

module Importers
  class Eventbrite

    def events
      client.user_list_events["events"].map do |entry|
        Event.new(entry["event"])
      end
    end

    def import_attendees eventbrite_id
      event = ::Event.find_by_eventbrite_xid(eventbrite_id.to_s)
      client.event_list_attendees({id: eventbrite_id})["attendees"].map do |entry|
        Attendee.new(entry["attendee"]).import event
      end
    end

    def update_added_events
      ::Event.find_each do |event|
        import_attendees event.eventbrite_xid
      end
    end

    private

    def config
      Configuration.instance
    end

    def client
      @client ||= EventbriteClient.new(app_key: config[:api_key], user_key: config[:user_key] )
    end
  end
end