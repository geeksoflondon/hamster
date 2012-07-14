require 'spec_helper'

describe Interaction do
  describe "#initialize" do
    it "should require interactable, key, and value" do
      -> { a_saved Interaction, interactable: nil }.should raise_error
      -> { a_saved Interaction, key: nil }.should raise_error
      -> { a_saved Interaction, value: nil }.should raise_error
      -> { a_saved Interaction, value: "" }.should raise_error
      -> { a_saved Interaction }.should_not raise_error
    end
  end
end
