require 'spec_helper'

describe "Event" do
  describe "#initialize" do
    it "should require a name" do
      -> { a_saved Event, name: nil }.should raise_error
      -> { a_saved Event, name: "KickAssAwesome Camp" }.should_not raise_error
    end

    it "should require a start date" do
      -> { a_saved Event, start_date: nil }.should raise_error
      -> { a_saved Event, start_date: "01/01/1900" }.should_not raise_error
    end

    it "should require a end date" do
      -> { a_saved Event, end_date: nil }.should raise_error
      -> { a_saved Event, end_date: "02/01/1900" }.should_not raise_error
    end
  end

  describe "#name" do
    it "should trim spaces" do
      event = a_saved Event, name: "Google IO "
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
      -> {a_saved Event, start_date: "01/01/1900"}.should_not raise_error
    end

    it "should be before #end_date" do
      -> {a_saved Event, start_date: "02/01/1900", end_date: "01/01/1900"}.should raise_error
      -> {a_saved Event, start_date: "01/01/1900", end_date: "02/01/1900"}.should_not raise_error
    end
  end

  describe "#end_date" do
    it "should only allow a valid date/time" do
      -> {a_saved Event, end_date: ""}.should raise_error
      -> {a_saved Event, end_date: "02/01/1900"}.should_not raise_error
    end

    it "should be after #start_date" do
      -> {a_saved Event, start_date: "02/01/1900", end_date: "01/01/1900"}.should raise_error
      -> {a_saved Event, start_date: "01/01/1900", end_date: "02/01/1900"}.should_not raise_error
    end
  end

end