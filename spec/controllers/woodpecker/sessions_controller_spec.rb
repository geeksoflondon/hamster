require 'spec_helper'

describe Woodpecker::SessionsController do

  before(:all) do
    @ticket = a_saved Ticket
  end

  describe "#index" do
    it "with a valid cookie" do
      request.cookies['woodpecker_token'] = @ticket.woodpecker_token
      get :index
      expect(response).to be_redirect
    end

    it "without a valid cookie" do
      get :index
      expect(response).to be_success
    end
  end

  describe "#create" do
    it "with a valid woodpecker token" do
      post :create, {:woodpecker_token => @ticket.woodpecker_token}
      expect(response.cookies['woodpecker_token']).to eq(@ticket.woodpecker_token)
      expect(response).to be_redirect
    end

    it "without a valid woodpecker token" do
      post :create, {:woodpecker_token => '654321'}
      expect(response.cookies['woodpecker_token']).to eq(nil)
      expect(response).to be_redirect
    end
  end

  describe "#create via /woodpecker/onetime/:woodpecker_token" do
    it "with a valid woodpecker token" do
      get :create, :woodpecker_token => @ticket.woodpecker_token
      expect(response.cookies['woodpecker_token']).to eq(@ticket.woodpecker_token)
      expect(response).to be_redirect
    end

    it "without a valid woodpecker token" do
      get :create, :woodpecker_token => 'abcdefg'
      expect(response.cookies['woodpecker_token']).to eq(nil)
      expect(response).to be_redirect
    end
  end

  describe "#verify_token" do
    before(:all) do
      @controller = Woodpecker::SessionsController.new
    end

    it "if woodpecker_token is nil" do
      @controller.instance_eval{ verify_token(nil) }.should eq(false)
    end

    it "if woodpecker_token is not found" do
      @controller.instance_eval{ verify_token('654321') }.should eq(false)
    end

    it "if woodpecker_token is found" do
      woodpecker_token =  @ticket.woodpecker_token
      @controller.instance_eval{ verify_token(woodpecker_token) }.should eq(true)
    end
  end

end
