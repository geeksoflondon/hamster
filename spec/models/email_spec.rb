require 'spec_helper'

describe Email do
  describe "#initialize" do
    it "should require an address and attendee" do
      -> { a_saved Email, address: nil }.should raise_error
      -> { a_saved Email, attendee: nil }.should raise_error
      email = a_saved Email, address: "john@doe.com"
      email.address.should be == "john@doe.com"
      email.attendee.should be_a(Attendee)
    end

    it "should be unique on the address and attendee combination" do
      attendee = a_saved Attendee
      address = "me@foobar.com"
      -> { a_saved Email, attendee: attendee, address: address }.should_not raise_error
      -> { a_saved Email, attendee: attendee, address: address }.should raise_error
    end
  end
end
