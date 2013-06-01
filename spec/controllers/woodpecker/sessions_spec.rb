require 'spec_helper'

describe Woodpecker::SessionsController do

  before(:all) do
    @ticket = a_saved Ticket
  end

  describe "#index" do
    it "with a valid cookie" do
      request.cookies['woodpecker_token'] = @ticket.woodpecker_password
      get :index
      expect(response).to be_redirect
    end

    it "without a valid cookie" do
      get :index
      expect(response).to be_success
    end
  end
  
  describe "#create" do
    it "with a valid woodpecker password" do
      post :create, {:woodpecker_password => @ticket.woodpecker_password}
      expect(response.cookies['woodpecker_token']).to eq(@ticket.woodpecker_password)
      expect(response).to be_redirect
    end

    it "without a valid woodpecker password" do
      post :create, {:woodpecker_password => '654321'}
      expect(response.cookies['woodpecker_token']).to eq(nil)
      expect(response).to be_redirect
    end
  end

  describe "#create via /woodpecker/onetime/:woodpecker_token" do
    it "with a valid woodpecker password" do
      get :create, :woodpecker_password => @ticket.woodpecker_password
      expect(response.cookies['woodpecker_token']).to eq(@ticket.woodpecker_password)
      expect(response).to be_redirect
    end

    it "without a valid woodpecker password" do
      get :create, :woodpecker_password => 'abcdefg'
      expect(response.cookies['woodpecker_token']).to eq(nil)
      expect(response).to be_redirect
    end
  end

  describe "#check_cookie" do
    before(:all) do
      @controller = Woodpecker::SessionsController.new
    end
    
    it "if woodpecker_password is nil" do
      @controller.instance_eval{ check_cookie(nil) }.should eq(false)
    end
    
    it "if woodpecker_password is not found" do
      @controller.instance_eval{ check_cookie('654321') }.should eq(false)
    end

    it "if woodpecker_password is found" do
      woodpecker_password =  @ticket.woodpecker_password
      @controller.instance_eval{ check_cookie(woodpecker_password) }.should eq(true)
    end
  end

end
