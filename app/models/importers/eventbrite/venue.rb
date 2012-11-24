module Importers
  class Eventbrite
    class Venue
      attr_accessor :name, :address

      def initialize data = {}
        data = data.with_indifferent_access
        self.name = data[:name]
        self.address = "#{data[:address]}\n#{data[:city]} #{data[:postal_code]}\n#{data[:country]}"
      end

      def imported?
        ::Venue.where(name: name).count > 0
      end

      def find_or_import
        ::Venue.where(name: name).first_or_create! address: address
      end

      def self.unknown
        Venue.new name: "To be determined", address: nil
      end
    end
  end
end