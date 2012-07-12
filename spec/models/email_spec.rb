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
  end
end
