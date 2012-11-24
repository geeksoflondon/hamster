require 'eventbrite-client'

module Importers
  class Eventbrite

    def events
      client.user_list_events["events"].map do |entry|
        Event.new(entry["event"])
      end
    end

    private

    def config
     Importers::Eventbrite::Configuration.instance
    end

    def client
      @client ||= EventbriteClient.new(app_key: config[:api_key], user_key: config[:user_key] )
    end
  end
end