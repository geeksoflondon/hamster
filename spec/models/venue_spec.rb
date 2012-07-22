require 'spec_helper'

describe Venue do
  describe "#initialize" do
    it "should require an address and name" do
      -> { a_saved Venue, address: nil }.should raise_error
      -> { a_saved Venue, name: nil }.should raise_error
      -> { a_saved Venue }.should_not raise_error
    end

    it "should be unique on the name" do
      -> { a_saved Venue, name: "Foobar" }.should_not raise_error
      -> { a_saved Venue, name: "Foobar" }.should raise_error
    end
  end
end
