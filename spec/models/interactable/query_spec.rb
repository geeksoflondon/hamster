require 'spec_helper'

describe Interactable::Query do
  describe "#execute" do
    before :all do
      @ticket1 = a_saved Ticket
      @ticket1.interactions.create! key: "confirmed", value: "true"
      @ticket1.interactions.create! key: "checkin", value: "true"
      @ticket1.interactions.create! key: "confirmed", value: "false"
      @ticket2 = a_saved Ticket
      @ticket2.interactions.create! key: "confirmed", value: "true"
      @ticket3 = a_saved Ticket
      @ticket3.interactions.create! key: "checkin", value: "true"
    end

    context "no interactions params" do
      it "should just return the class" do
        params = { "name" => "John Doe" }
        Interactable::Query.new(klass: Ticket, params: params).execute.should be == Ticket
      end
    end

    context "=" do
      it "should return only the entries with the current state" do
        params = { "interactions.confirmed =" => "true" }
        Interactable::Query.new(klass: Ticket, params: params).execute.should be == [@ticket2]
      end
    end

    context "!=" do
      it "should return only the entries without the current state" do
        params = { "interactions.confirmed !=" => "true" }
        Interactable::Query.new(klass: Ticket, params: params).execute.should be == [@ticket1]
      end
    end

    context "~" do
      it "should return all the entries who ever had the state" do
        params = { "interactions.confirmed ~" => "true" }
        Interactable::Query.new(klass: Ticket, params: params).execute.should be == [@ticket1, @ticket2]
      end
    end

    context "!~" do
      it "should return all the entries who never had the state" do
        params = { "interactions.confirmed !~" => "true" }
        Interactable::Query.new(klass: Ticket, params: params).execute.should be == [@ticket3]
      end
    end

    context "when handling date ranges" do
      it "should respect the date limits" do
        @ticket2.interactions.first.update_attribute(:created_at, 10.days.ago)
        params = { "interactions.confirmed ~" => "true", "created_at <" =>1.day.ago.to_s }
        Interactable::Query.new(klass: Ticket, params: params).execute.should be == [@ticket2]
      end
    end

    context "when combining queries" do
      it "should find the right interactables" do
        params = { "interactions.confirmed !=" => "true", "checkin ~" => "true" } # unconfirmed people that showed up
        Interactable::Query.new(klass: Ticket, params: params).execute.should be == [@ticket1]
      end
    end
  end
end
