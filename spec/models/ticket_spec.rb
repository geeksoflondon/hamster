require 'spec_helper'

describe Ticket do
  describe "#initialize" do
    it "should require an attendee, an event and an eventbrite_xid" do
      -> { a_saved Ticket, attendee: nil }.should raise_error
      -> { a_saved Ticket, event: nil }.should raise_error
      -> { a_saved Ticket, eventbrite_xid: nil }.should raise_error
      -> { a_saved Ticket }.should_not raise_error
    end

    it "should be unique on the event and attendee combination" do
      attendee = a_saved Attendee
      event = a_saved Event
      -> { a_saved Ticket, attendee: attendee, event: event }.should_not raise_error
      -> { a_saved Ticket, attendee: attendee, event: event }.should raise_error
    end

    it "should have a unique eventbrite_xid" do
      ticket1 = a_saved Ticket, eventbrite_xid: "123456"
      ticket1.should be_valid
      ticket2 = a Ticket, eventbrite_xid: "123456"
      ticket2.should_not be_valid
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
      ticket.should_not be_valid
    end
  end

  describe "#interactions" do
    it "should have many interactions" do
      ticket = a_saved Ticket
      ticket.interactions.create! key: "foo", value: "bar"
      ticket.interactions.should have(1).interaction
      ticket.interactions.create! key: "foo", value: "bar2"
      ticket.interactions.should have(2).interactions
    end
  end
end
