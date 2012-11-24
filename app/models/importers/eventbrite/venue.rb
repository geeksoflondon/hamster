module Importers
  class Eventbrite
    class Venue
      attr_accessor :name, :address

      def initialize data = {}
        data = data.with_indifferent_access
        self.name = data[:name]
        self.address = parse_address(data)
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

      private

      def parse_address data
        cleaned_data = [
          data[:address],
          data[:city],
          data[:postal_code],
          data[:country]
        ].compact.join("\n")
      end
    end
  end
end