module Importers
  class Eventbrite
    class Configuration

      def self.instance
        @@config ||= YAML.load_file(location)[Rails.env].with_indifferent_access
      end

      def self.location
        Rails.env.test? ? "spec/config/eventbrite.yml" : "config/eventbrite.yml"
      end
    end
  end
end