require 'spec_helper'

describe Attendee do
  describe "#initialize" do
    it "should require a name" do
      -> { a_saved Attendee, first_name: nil, last_name: nil }.should raise_error
      -> { a_saved Attendee, first_name: "", last_name: "" }.should raise_error
      -> { a_saved Attendee, first_name: "John", last_name: "" }.should_not raise_error
    end
  end

  describe "#name" do
    it "can not be blank" do
      attendee = a Attendee, first_name: nil, last_name: nil
      attendee.valid?.should be_false
      attendee.first_name = "John"
      attendee.valid?.should be_true
    end

    it "is build from the first and last name" do
      attendee = a_saved Attendee, first_name: "Bob", last_name: "Smith"
      attendee.name.should be == "Bob Smith"
    end

    it "should trim spaces" do
      attendee = a_saved Attendee, first_name: "Bob ", last_name: " Smith "
      attendee.name.should be == "Bob Smith"
    end
  end

  describe "#twitter" do
    it "should leave nil" do
      attendee = a_saved Attendee, twitter: nil
      attendee.twitter.should be_nil
    end

    it "should remove @ signs" do
      attendee = a_saved Attendee, twitter: "@cbetta"
      attendee.twitter.should be == "cbetta"
    end

    it "should remove double @ signs" do
      attendee = a_saved Attendee, twitter: "@@cbetta"
      attendee.twitter.should be == "cbetta"
    end

    it "removes invalid characters" do
      attendee = a_saved Attendee, twitter: "  @cbe$!tt-a  "
      expect(attendee.twitter).to eq "cbetta"
    end

    it "accepts valid characters" do
      attendee = a_saved Attendee, twitter: "twitterer_123"
      expect(attendee.twitter).to eq "twitterer_123"
    end
  end

  describe "#tshirt" do
    it "can only be one of the valid sizes" do
      attendee = a Attendee, tshirt: Attendee::Tshirt::MALE_XXL
      attendee.valid?.should be_true
      attendee.save!
      attendee.tshirt.should be == Attendee::Tshirt::MALE_XXL

      attendee = a Attendee, tshirt: 101
      attendee.valid?.should be_false
    end

    it "can be nil" do
      attendee = a Attendee, tshirt: nil
      attendee.valid?.should be_true
    end
  end

  describe "#diet" do
    it "can only be one of the valid types" do
      attendee = a Attendee, diet: Attendee::Diet::VEGETARIAN
      attendee.valid?.should be_true
      attendee.save!
      attendee.diet.should be == Attendee::Diet::VEGETARIAN

      attendee = a Attendee, diet: 101
      attendee.valid?.should be_false
    end

    it "can be nil" do
      attendee = a Attendee, diet: nil
      attendee.valid?.should be_true
    end
  end

  describe "#is_public" do
    it "can not be nil" do
      attendee = a Attendee
      attendee.is_public = nil
      attendee.valid?.should be_false
      attendee.is_public = true
      attendee.valid?.should be_true
      attendee.is_public = false
      attendee.save!
      attendee.valid?.should be_true
    end
  end

  describe "#emails" do
    it "should be able to have many emails" do
      attendee = a_saved Attendee
      attendee.emails.create! address: "john@doe.com"
      attendee.emails.should have(1).email
      attendee.emails.create! address: "me@johndoe.com"
      attendee.emails.should have(2).emails
    end
  end

  describe "#interactions" do
    it "should have many interactions" do
      attendee = a_saved Attendee
      attendee.interactions.create! key: "foo", value: "bar"
      attendee.interactions.should have(1).interaction
      attendee.interactions.create! key: "foo", value: "bar2"
      attendee.interactions.should have(2).interactions
    end
  end
end
