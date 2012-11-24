module Importers
  class Eventbrite
    class Configuration

      def self.instance
        @@config ||= YAML.load_file("config/eventbrite.yml")[Rails.env].with_indifferent_access
      end

    end
  end
end