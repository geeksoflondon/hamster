require 'spec_helper'
require 'importers/eventbrite'

describe Importers::Eventbrite do

  describe "#events" do
    use_vcr_cassette

    it "should return the current events" do
      events = Importers::Eventbrite.new.events
      events.should be_a(Array)
      events.each do |event|
        event.should be_a(Importers::Eventbrite::Event)
      end
      events.first.title.should be == "Barcamp London 6"
    end
  end

  describe "#import_attendees" do
    use_vcr_cassette

    it "should return the attendees of an event" do
      a_saved Event, eventbrite_xid: "6107871809"
      attendees = Importers::Eventbrite.new.import_attendees "6107871809"
      attendees.should be_a(Array)
      attendees.each do |attendee|
        attendee.should be_a(::Attendee)
      end
    end
  end
end