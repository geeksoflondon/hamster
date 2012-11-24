require 'spec_helper'

describe Importers::Eventbrite::Event do

  describe "#imported?" do
    before do
      @event = Importers::Eventbrite::Event.new(title: "Foobar", id: 1234567)
    end

    it "should return true if already imported" do
      a_saved Event, eventbrite_xid: "1234567"
      @event.should be_imported
    end

    it "should return false if not already imported" do
      @event.should_not be_imported
    end
  end
end