require 'spec_helper'

describe ConfirmationsController do

  before(:each) do
    @ticket = a_saved Ticket
    @retain_token = @ticket.get(Ticket::RETAIN_TOKEN).to_s
  end

  describe "#index" do
    it "should return a help page" do
      get :index
      expect(response).to be_success
    end
  end
  
  describe "#show" do
    it "should return a page with a url token" do
      get :show, id: @retain_token
      expect(response).to be_success
    end
  end
  
  describe "#edit" do
    it "should return a page with a url token" do
      get :edit, id: @retain_token
      expect(response).to be_success
    end
  end

  describe "#update" do
    it "should update ticket as confirmed" do
      put :update, {id: @retain_token, attending: "true"}
      @ticket.reload
      @ticket.is_confirmed?.should == true
    end

    it "should update ticket as attending" do
      put :update, {id: @retain_token, attending: "true"}
      @ticket.reload
      @ticket.is_attending?.should == true
    end

    it "should update ticket as cancelled" do
      put :update, {id: @retain_token, attending: "false"}
      @ticket.reload
      @ticket.is_attending?.should == false
    end

    it "should update first_name" do
      put :update, {id: @retain_token, attending: "true", first_name: "Geeks"}
      @ticket.attendee.reload
      @ticket.attendee.first_name.should == "Geeks"
    end

    it "should update last_name" do
      put :update, {id: @retain_token, attending: "true", last_name: "London"}
      @ticket.attendee.reload
      @ticket.attendee.last_name.should == "London"
    end

    it "should update twitter" do
      put :update, {id: @retain_token, attending: "true", twitter: "geeksoflondon"}
      @ticket.attendee.reload
      @ticket.attendee.twitter.should == "geeksoflondon"
    end

    it "should update saturday as attending" do
      put :update, {id: @retain_token, attending: "true", saturday: "true"}
      @ticket.reload
      @ticket.is_attending_saturday?.should == true
    end

    it "should update saturday as not attending" do
      put :update, {id: @retain_token, attending: "true", saturday: "false"}
      @ticket.reload
      @ticket.is_attending_saturday?.should == false
    end

    it "should update sunday attending" do
      put :update, {id: @retain_token, attending: "true", sunday: "true"}
      @ticket.reload
      @ticket.is_attending_sunday?.should == true
    end

    it "should update sunday as not attending" do      
      put :update, {id: @retain_token, attending: "true", sunday: "false"}
      @ticket.reload
      @ticket.is_attending_sunday?.should == false
    end

    it "should update overnight as attending" do
      put :update, {id: @retain_token, attending: "true", overnight: "true"}
      @ticket.reload
      @ticket.is_attending_overnight?.should == true
    end

    it "should update overnight as not attending" do
      put :update, {id: @retain_token, attending: "true", overnight: "false"}
      @ticket.reload
      @ticket.is_attending_overnight?.should == false
    end

  end

end
