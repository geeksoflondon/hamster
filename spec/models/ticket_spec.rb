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
