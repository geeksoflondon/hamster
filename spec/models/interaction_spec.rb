require 'spec_helper'

describe Interaction do
  describe "#initialize" do
    it "should require interactable, key, and value" do
      -> { a_saved Interaction, interactable: nil }.should raise_error
      -> { a_saved Interaction, key: nil }.should raise_error
      -> { a_saved Interaction }.should_not raise_error
    end
  end

  describe "#expire_previous_states" do
    it "should expire older version of the same key" do
      attendee = a_saved Attendee
      old_interaction = a_saved Interaction, key: "foo", value: "old", interactable: attendee
      old_interaction.current.should be_true
      new_interaction = a_saved Interaction, key: "foo", value: "new", interactable: attendee
      old_interaction.reload.current.should be_false
      new_interaction.current.should be_true
    end

    it "should only expire older versions of the same key" do
      attendee = a_saved Attendee
      first_interaction = a_saved Interaction, key: "foo", value: "duck", interactable: attendee
      second_interaction = a_saved Interaction, key: "bar", value: "cow", interactable: attendee

      a_saved Interaction, key: "foo", value: "goose", interactable: attendee

      first_interaction.reload.current.should be_false
      second_interaction.reload.current.should be_true
    end
  end

  describe "#value=" do
    it "should keep type on save" do
      interaction = a_saved Interaction, value: true
      interaction.send(:read_attribute, :value).should be_true
    end
  end
end

