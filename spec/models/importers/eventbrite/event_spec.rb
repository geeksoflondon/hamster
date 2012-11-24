require 'spec_helper'

describe Importers::Eventbrite::Event do
  before :each do
    params = {
      title: "Foobar",
      id: 1234567,
      start_date: Time.now + 1.day,
      end_date: Time.now + 2.days
    }
    @event = Importers::Eventbrite::Event.new params
  end

  describe "#imported?" do
    it "should return true if already imported" do
      a_saved Event, eventbrite_xid: "1234567"
      @event.should be_imported
    end

    it "should return false if not already imported" do
      @event.should_not be_imported
    end
  end

  describe "#import" do
    it "should raise an error if the event was already imported" do
      a_saved Event, eventbrite_xid: "1234567"
      -> { @event.import }.should raise_exception(ArgumentError)
    end

    it "should import an unimported event" do
      @event.import
      @event.should be_imported
    end
  end
end