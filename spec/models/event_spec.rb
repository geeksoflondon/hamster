require 'spec_helper'

describe "Event" do
  describe "#initialize" do
    it "should require a name" do
      -> { a_saved Event, name: nil }.should raise_error
      -> { a_saved Event, name: "KickAssAwesome Camp" }.should_not raise_error
    end

    it "should require a start date" do
      -> { a_saved Event, start_date: nil }.should raise_error
    end

    it "should require an end date" do
      -> { a_saved Event, end_date: nil }.should raise_error
    end

    it "should require an eventbrite xid" do
      -> { a_saved Event, eventbrite_xid: nil }.should raise_error
      -> { a_saved Event, eventbrite_xid: "1234567" }.should_not raise_error
    end
  end

  describe "#eventbrite_xid" do
    it "should be unique" do
      event1 = a_saved Event, eventbrite_xid: "1234567"
      event1.should be_valid

      event2 = a Event, eventbrite_xid: "1234567"
      event2.should_not be_valid
    end
   end

  describe "#name" do
    it "should trim spaces" do
      event = a_saved Event, name: "Google IO "
      event.name.should be == "Google IO"

      event = a_saved Event, name: " Google IO"
      event.name.should be == "Google IO"
    end
  end

  describe "#url" do
    it "should be able to be nil" do
      -> {a_saved Event, url: nil}.should_not raise_error
    end

    it "should be a valid url" do
      -> {a_saved Event, url: "hstp://www.bbc.co.uk/"}.should raise_error
      -> {a_saved Event, url: "http://www.bbc.co.uk/"}.should_not raise_error
    end
  end

  describe "#start_date" do
    it "should only allow a valid date/time" do
      -> {a_saved Event, start_date: ""}.should raise_error
    end

    it "should be before #end_date" do
      -> {a_saved Event, start_date: 2.days.from_now, end_date: 1.days.from_now}.should raise_error
      -> {a_saved Event, start_date: 1.days.from_now, end_date: 2.days.from_now}.should_not raise_error
    end

    it "allows one day events where #start_date and #end_date are the same" do
      -> {a_saved Event, start_date: "01/01/1900", end_date: "01/01/1900"}.should_not raise_error
    end
  end

  describe "#end_date" do
    it "should only allow a valid date/time" do
      -> {a_saved Event, end_date: ""}.should raise_error
    end

    it "should be after #start_date" do
      -> {a_saved Event, start_date: 2.days.from_now, end_date: 1.day.from_now}.should raise_error
    end
  end

  describe "#english_date" do
    it "should convert the date to a readable format" do
      start_date = DateTime.new(2013, 8, 15, 8)
      end_date1 = DateTime.new(2013, 8, 16, 17)
      event1 = a_saved Event, start_date: start_date, end_date: end_date1
      event1.english_date.should be == "from August 15th, 2013 to August 16th, 2013"

      end_date2 = DateTime.new(2013, 8, 15, 17)
      event2 = a_saved Event, start_date: start_date, end_date: end_date2
      event2.english_date.should be == "on August 15th, 2013"
    end
  end

end
