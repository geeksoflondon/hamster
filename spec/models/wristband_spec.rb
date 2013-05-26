require 'spec_helper'

describe Wristband do
  describe "#create" do
    before(:each) do
      @ticket = a_saved Ticket
      @attendee = a_saved Attendee
    end
    
    it "should require a valid ticket" do
      expect { Wristband.create(@attendee, "123456") }.to raise_error
      expect { Wristband.create(nil, "123456") }.to raise_error
      expect { Wristband.create(@ticket, "123456") }.to_not raise_error
    end
    
    it "should require the wristband id to be unused" do
      Wristband.create(@ticket, "123456")
      expect { Wristband.create(@ticket, "123456") }.to raise_error
      expect { Wristband.create(@ticket, "654321") }.to_not raise_error
    end
  end

  describe "#find" do
    before(:each) do
      @ticket = a_saved Ticket
      @attendee = a_saved Attendee
      @wristband = Wristband.create(@ticket, "123456")
    end
    
    it "should return a ticket object for a valid wristband id" do
      ticket = Wristband.find("123456")
      ticket.should be_an_instance_of Ticket
      ticket.id.should equal(@ticket.id)
    end
    
    it "should return nil for a missing wristband id" do
      expect(Wristband.find("999999")).to be_nil
    end
  end
end
