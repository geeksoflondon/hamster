require 'spec_helper'

describe Importers::Eventbrite do
  use_vcr_cassette

  describe "#events" do
    it "should return the current events" do
      events = Importers::Eventbrite.new.events
      events.should be_a(Array)
      events.each do |event|
        event.should be_a(Importers::Eventbrite::Event)
      end
      events.first.title.should be == "Barcamp London 6"
    end
  end
end