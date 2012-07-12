require 'spec_helper'

describe Ticket do
  describe "#initialize" do
    it "should require an attendee and an event" do
      -> { a_saved Ticket, attendee: nil }.should raise_error
      -> { a_saved Ticket, event_id: nil }.should raise_error
      -> { a_saved Ticket }.should_not raise_error
    end

    it "should be unique on the event and attendee combination" do
      attendee = a_saved Attendee
      -> { a_saved Ticket, attendee: attendee, event_id: 1 }.should_not raise_error
      -> { a_saved Ticket, attendee: attendee, event_id: 1 }.should raise_error
    end
  end
end
