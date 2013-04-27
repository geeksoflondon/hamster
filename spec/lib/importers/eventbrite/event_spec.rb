require 'spec_helper'
require 'importers/eventbrite'

describe Importers::Eventbrite::Event do
  before :each do
    params = {
      title: "Foobar",
      id: 1234567,
      start_date: 1.day.from_now,
      end_date: 2.days.from_now,
      url: "http://example.com"
    }
    @event = Importers::Eventbrite::Event.new params
  end

  describe "#imported?" do
    it "should return true if already imported" do
      a_saved Event, eventbrite_xid: "1234567"
      @event.imported?.should be_true
    end

    it "should return false if not already imported" do
      @event.imported?.should_not be_true
    end
  end

  describe "#import" do
    it "should raise an error if the event was already imported" do
      a_saved Event, eventbrite_xid: "1234567"
      -> { @event.import }.should raise_exception(ArgumentError)
    end

    it "should import an unimported event" do
      ::Event.count.should be == 0

      @event.import

      @event.should be_imported
      ::Event.count.should be == 1
    end
  end
end