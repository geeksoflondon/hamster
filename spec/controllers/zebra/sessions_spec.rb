require 'spec_helper'

describe Zebra::SessionsController do

  before(:all) do
    @ticket = a_saved Ticket
    @ticket.kind = Ticket::Kind::CREW
    @ticket.save
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
      expect(response).to be_redirect
    end

    it "without a valid wristband id" do
      post :create, {:wristband => '654321'}
      expect(response.cookies['zebra_token']).to eq(nil)
      expect(response).to be_redirect
    end
  end

  describe "#check_cookie" do
    
    before(:all) do
      @controller = Zebra::SessionsController.new
    end
    
    it "if wristband_id is nil" do
      @controller.instance_eval{ check_cookie(nil) }.should eq(false)
    end
    
    it "if wristband_id is not found" do
      @controller.instance_eval{ check_cookie('654321') }.should eq(false)
    end
    
    it "if wristband_id is not a crew ticket type" do
      ticket = a_saved Ticket
      ticket.save
      ticket.interactions.create(:key => 'wristband', :value => '234567')
      @controller.instance_eval{ check_cookie('234567') }.should eq(false)
    end
    
    it "if wristband_id is found and is a crew ticket type" do
      @controller.instance_eval{ check_cookie('123456') }.should eq(true)
    end
  end

end
