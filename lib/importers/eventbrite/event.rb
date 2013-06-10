module Importers
  class Eventbrite
    class Event
      attr_accessor :title, :id, :start_date, :end_date, :venue, :url

      def initialize data = {}
        data = data.with_indifferent_access
        self.title = data[:title]
        self.id = data[:id]
        self.start_date = data[:start_date]
        self.end_date = data[:end_date]
        self.url = data[:url]
        self.venue = data[:venue] ? Venue.new(data[:venue]) : Venue.unknown
      end

      def imported?
        ::Event.where(eventbrite_xid: id.to_s).count > 0
      end

      def import
        raise ArgumentError.new("Event has already been imported") if imported?

        ::Event.create!({
          venue: venue.find_or_import,
          name: title,
          eventbrite_xid: id,
          start_date: start_date,
          end_date: end_date,
          url: url
        })
      end

    end
  end
end