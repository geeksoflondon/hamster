require 'spec_helper'

describe Zebra::ZebraController do

  describe "without a valid token" do
    it "#index" do
      get :index
      expect(response).to be_success
    end
    
    it "#new" do
      get :help
      expect(response).to be_redirect
    end
  end

  describe "with a valid token" do
    
    before(:all) do
      ticket = a_saved Ticket
      ticket.kind = Ticket::Kind::CREW
      ticket.save
      ticket.interactions.create(:key => 'wristband', :value => '123456')
    end
    
    it "#new" do
      request.cookies['zebra_token'] = "123456"
      get :help
      expect(response).to be_success
    end
  end

  describe "with an invalid token" do

    before(:all) do
      ticket = a_saved Ticket
      ticket.interactions.create(:key => 'wristband', :value => '654321')
    end

    it "#new" do
      request.cookies['zebra_token'] = "654321"
      get :help
      expect(response).to be_redirect
    end

  end

end
