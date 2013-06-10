require 'spec_helper'

describe Interactable do

  context "for instances" do
    before :each do
      @interactable = a_saved Ticket
      @key = "foo"
    end

    describe "#is" do
      it "should set the value to true" do
        @interactable.is @key
        expect(Interaction.where(key: @key, current: true).first.value).to be == true
      end

      it "should overwrite previous values" do
        @interactable.isnt @key
        expect(Interaction.where(key: @key, current: true).first.value).to be == false
        @interactable.is @key
        expect(Interaction.where(key: @key, current: true).first.value).to be == true
      end
    end

    describe "#isnt" do
      it "should set the value to false" do
        @interactable.isnt @key
        expect(Interaction.where(key: @key, current: true).first.value).to be == false
      end

      it "should overwrite previous values" do
        @interactable.is @key
        expect(Interaction.where(key: @key, current: true).first.value).to be == true
        @interactable.isnt @key
        expect(Interaction.where(key: @key, current: true).first.value).to be == false
      end
    end

    describe "#has" do
      it "should set the key to the given value" do
        @interactable.has @key, "foo"
        expect(Interaction.where(key: @key, current: true).first.value).to be == "foo"
      end

      it "should overwrite previous values" do
        @interactable.has @key, "foo"
        expect(Interaction.where(key: @key, current: true).first.value).to be == "foo"
        @interactable.has @key, "bar"
        expect(Interaction.where(key: @key, current: true).first.value).to be == "bar"
      end
    end

    describe "#get" do
      it "should get current value" do
        @interactable.has @key, "foo"
        expect(@interactable.get(@key)).to be == "foo"
      end

      it "should not get the previous value" do
        @interactable.has @key, "foo"
        @interactable.has @key, "bar"
        expect(@interactable.get(@key)).to be == "bar"
      end
    end

    describe "#is_*?" do
      it "should return if the value for the key is true" do
        @interactable.is "foo"
        expect(@interactable.is_foo?).to be_true
      end
    end

    describe "#is_*!" do
      it "should set the value for the key to true" do
        @interactable.is_foo!
        expect(@interactable.is_foo?).to be_true
      end

      it "should overwrite previous values" do
        @interactable.isnt_foo!
        @interactable.is_foo!
        expect(@interactable.is_foo?).to be_true
      end
    end

    describe "#isnt_!" do
      it "should set the value for the key to false" do
        @interactable.isnt_foo!
        expect(@interactable.is_foo?).to be_false
      end

      it "should overwrite previous values" do
        @interactable.is_foo!
        @interactable.isnt_foo!
        expect(@interactable.is_foo?).to be_false
      end
    end

    describe "#has_*?" do
      it "should return if the value for the key has ever been set" do
        expect(@interactable.has_foo?).to be_false
        @interactable.has "foo", "bar"
        expect(@interactable.has_foo?).to be_true
      end
    end
  end

  context "for classes" do
    before :each do
      @interactable1 = a_saved Ticket
      @interactable1.has "foo", "bar"
      @interactable2 = a_saved Event
      @interactable2.has "foo", "bar"
    end

    describe ".interactions" do
      it "should retreive all interactions belonging to a key/value and class" do
        Ticket.interactions("foo", "bar").should be == [@interactable1.interactions.last]
      end
    end

    describe ".interaction" do
      it "should retreive the latest interaction belonging to a key/value and class" do
        Ticket.interaction("foo", "bar").should be == @interactable1.interactions.last
      end
    end

    describe ".get" do
      it "should return the latest interactable for the given key/value and class" do
        Ticket.get("foo", "bar").should be == @interactable1
      end
    end

    describe ".get_all" do
      it "should return all interactables for the given key/value and class" do
        Ticket.get_all("foo", "bar").should be == [@interactable1]
      end
    end
  end
end
