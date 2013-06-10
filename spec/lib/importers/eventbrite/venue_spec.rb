require 'spec_helper'
require 'importers/eventbrite'

describe Importers::Eventbrite::Venue do

  before :each do
    params = {
      name: "Foobar Club",
      address: "1 Foobar Place, Foobarshire SE12 34DE, UK"
    }
    @venue = Importers::Eventbrite::Venue.new params
  end
  describe "#imported?" do
    it "should return true if already imported" do
      a_saved Venue, name: "Foobar Club"
      @venue.should be_imported
    end

    it "should return false if not already imported" do
      @venue.should_not be_imported
    end
  end

  describe "#find_or_import" do
    it "should return existing if the venue was already imported" do
      existing_venue = a_saved Venue, name: "Foobar Club"
      @venue.find_or_import.should be == existing_venue
    end

    it "should import an unimported venue" do
      @venue.find_or_import.should be_a(Venue)
      @venue.should be_imported
    end

    it "should be able to import the unknown venue" do
      venue = Importers::Eventbrite::Venue.unknown.find_or_import
      venue.should be_a(Venue)
      venue.name.should be == Importers::Eventbrite::Venue.unknown.name
      venue.address.should be == ""
      Importers::Eventbrite::Venue.unknown.should be_imported
    end
  end

  describe ".unknown" do
    it "should return the default unknow venue instance" do
      venue = Importers::Eventbrite::Venue.unknown
      venue.should be_a(Importers::Eventbrite::Venue)
      venue.name.should be == "To be determined"
      venue.address.should be == ""
    end
  end
end