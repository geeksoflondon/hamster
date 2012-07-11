module Hamster
  class Config

    def initialize
      self.options = YAML.load_file(Rails.root.join("config/hamster.yml")).with_indifferent_access
    rescue
      self.options = {}.with_indifferent_access
      options["user"] = ENV["HAMSTER_USER"]
      options["password"] = ENV["HAMSTER_PASSWORD"]
    end

    def [] key
      options[key]
    end

    def self.get key
      self.instance[key]
    end

    def self.instance
      @instance ||= Hamster::Config.new
    end

    protected

    attr_accessor :options

  end
end