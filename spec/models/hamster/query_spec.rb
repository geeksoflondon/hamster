require 'spec_helper'

describe Hamster::Query do
  describe "#initialize" do
    before :all do
      @attendees = Array.new(9) { a_saved Attendee }
      @attendees10 = a Attendee
      @attendees10.created_at = Time.now + 1.hour
      @attendees10.save!
    end


    it "should filter standard params" do
      params = {"name" => @attendees.first.name, "action" => "foo", "controller" => "foo", "format" => "foo"}
      Hamster::Query.new(klass: Attendee, params: params).execute.should be == [@attendees.first]
    end

    it "should apply limits" do
      params = {"limit" => 5}
      Hamster::Query.new(klass: Attendee, params: params).execute.should have(5).attendees
    end

    it "should apply offsets" do
      params = {"offset" => 5}
      Hamster::Query.new(klass: Attendee, params: params).execute.should have(5).attendees
    end

    it "should apply order" do
      params = {"order" => "created_at DESC", "limit" => 1}
      Hamster::Query.new(klass: Attendee, params: params).execute.should be == [@attendees10]
    end

    it "should handle interactions" do
      @attendees.first.interactions.create! key: "confirmed", value: "true"
      params = {"interactions.confirmed =" => "true"}
      Hamster::Query.new(klass: Attendee, params: params).execute.should be == [@attendees.first]
    end

    it "should query by filter options" do
      params = {"name" => @attendees.first.name}
      Hamster::Query.new(klass: Attendee, params: params).execute.should be == [@attendees.first]
    end
  end
end
