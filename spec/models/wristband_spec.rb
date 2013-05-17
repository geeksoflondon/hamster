require 'spec_helper'

describe Wristband do
  describe "#create" do
    it "should require a valid ticket id" do
    end
    
    it "should require the wristband id to be unused" do
    end
    
    it "should create a ticket interactable with a key of wristband" do
    end
    
    it "should return true" do
    end
  end
  
  describe "#swap" do
    it "should require the original wristband to exist" do
    end
    
    it "should require the new wristband to be unused" do
    end
    
    it "should update the ticket interactable with the key of wristband with the value of the new id" do
    end
  end
  
  describe "#find" do
    it "should return false for a missing wristband id" do
    end
    
    it "should return a ticket object for a valid wristband id" do
    end
  end
  
  describe "#exists?" do
    it "should return false if the wristband id is not found" do
    end
    
    it "should return true if the wristband id is found" do
    end
  end
end
