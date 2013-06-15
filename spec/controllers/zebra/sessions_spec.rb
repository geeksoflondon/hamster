require 'spec_helper'

describe Zebra::SessionsController do

  before(:all) do
    @ticket = a_saved Ticket, kind: Ticket::Kind::CREW
    @ticket.interactions.create(:key => 'wristband', :value => '123456')
  end

  describe "#index" do
    it "with a valid cookie" do
      request.cookies['zebra_token'] = "123456"
      get :index
      expect(response).to be_redirect
    end

    it "without a valid cookie" do
      get :index
      expect(response).to be_success
    end
  end
  
  describe "#create" do
    it "with a valid wristband id" do
      post :create, {:wristband => '123456'}
      expect(response.cookies['zebra_token']).to eq('123456')
      expect(response.cookies['zebra_event']).to eq(@ticket.event_id.to_s)
      expect(response).to be_redirect
    end

    it "without a valid wristband id" do
      post :create, {:wristband => '654321'}
      expect(response.cookies['zebra_token']).to eq(nil)
      expect(response.cookies['zebra_event']).to eq(nil)
      expect(response).to be_redirect
    end
  end
  
  describe "#destroy" do
    it "when called" do
      delete :destroy
      expect(response.cookies['zebra_token']).to eq(nil)
      expect(response.cookies['zebra_event']).to eq(nil)
      expect(response).to be_redirect
    end
  end

  describe "#get_wristband" do

    before(:all) do
      @controller = Zebra::SessionsController.new
    end

    it "if wristband_id is nil" do
      @controller.instance_eval{ get_wristband(nil) }.should eq(false)
    end
    
    it "if wristband_id is not found" do
      @controller.instance_eval{ get_wristband('654321') }.should eq(false)
    end
    
    it "if wristband_id found" do
      @controller.instance_eval{ get_wristband('123456') }.should be_an(Ticket)
    end
    
  end

  describe "#check_cookie" do
    
    before(:all) do
      @controller = Zebra::SessionsController.new
    end
    
    it "if wristband_id is not a crew ticket type" do
      attendee_ticket = a_saved Ticket, kind: Ticket::Kind::REGULAR
      attendee_ticket.interactions.create(:key => 'wristband', :value => '234567')
      @controller.instance_eval{ check_cookie('234567') }.should eq(false)
    end
    
    it "if wristband_id is found and is a crew ticket type" do
      @controller.instance_eval{ check_cookie('123456') }.should eq(true)
    end
    
    it "if wristband_id is found and is a manager ticket type" do
      manager_ticket = a_saved Ticket, kind: Ticket::Kind::MANAGER
      manager_ticket.interactions.create(:key => 'wristband', :value => '345678')
      @controller.instance_eval{ check_cookie('345678') }.should eq(true)
    end
  end

end
