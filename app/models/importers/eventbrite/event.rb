module Importers
  class Eventbrite
    class Event
      attr_accessor :title, :id

      def initialize data = {}
        data = data.with_indifferent_access
        self.title = data[:title]
        self.id = data[:id]
      end

      def imported?
        ::Event.where(eventbrite_xid: id.to_s).count > 0
      end
    end
  end
end