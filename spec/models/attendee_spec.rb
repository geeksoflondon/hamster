require 'spec_helper'

describe Attendee do
  describe "#initialize" do
    it "should require a name, type, and barcode"
  end

  describe "#name" do
    it "can not be blank"
    it "is build from the first and last name"
  end

  describe "#twitter" do
    it "should clean up double @ signs"
  end

  describe "#tshirt" do
    it "can only be one of the valid sizes"
  end

  describe "#type" do
    it "can not be blank"
    it "can only be one of the valid types"
  end

  describe "#public" do
    it "can not be blank"
  end

  describe "#barcode" do
    it "should be auto generated"
    it "should not be generated if already set"
  end
end
