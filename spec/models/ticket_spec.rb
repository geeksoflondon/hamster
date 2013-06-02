require 'spec_helper'

describe Ticket do
  describe "#initialize" do
    it "should require an attendee and an event" do
      -> { a_saved Ticket, attendee: nil }.should raise_error
      -> { a_saved Ticket, event: nil }.should raise_error
      -> { a_saved Ticket }.should_not raise_error
    end

    it "should be unique on the event and attendee combination" do
      attendee = a_saved Attendee
      event = a_saved Event
      -> { a_saved Ticket, attendee: attendee, event: event }.should_not raise_error
      -> { a_saved Ticket, attendee: attendee, event: event }.should raise_error
    end

    it "should have a retain token generated" do
      ticket = a_saved Ticket
      ticket.get(Ticket::RETAIN_TOKEN).should_not be_nil
    end
  end

  describe "#kind" do
    it "should be auto set" do
      ticket = a_saved Ticket
      ticket.kind.should be == Ticket::Kind::REGULAR
    end

    it "can not be nil" do
      ticket = a_saved Ticket
      ticket.kind = nil
      ticket.save!
      ticket.kind.should be == Ticket::Kind::REGULAR
    end

    it "can only be one of the valid types" do
      ticket = a_saved Ticket
      ticket.kind = 101
      ticket.valid?.should be_false
    end
  end

  describe "#interactions" do
    it "should have many interactions" do
      ticket = a_saved Ticket
      ticket.interactions.create! key: "foo", value: "bar"
      ticket.interactions.should have(2).interaction
      ticket.interactions.create! key: "foo", value: "bar2"
      ticket.interactions.should have(3).interactions
    end
  end
end
