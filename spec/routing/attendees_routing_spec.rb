require "spec_helper"

describe AttendeesController do
  describe "routing" do

    it "routes to #index" do
      get("/attendees").should route_to("attendees#index")
    end

    it "routes to #show" do
      get("/attendees/1").should route_to("attendees#show", :id => "1")
    end

    it "routes to #create" do
      post("/attendees").should route_to("attendees#create")
    end

    it "routes to #update" do
      put("/attendees/1").should route_to("attendees#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/attendees/1").should route_to("attendees#destroy", :id => "1")
    end

    it "should nest tickets" do
      get("/attendees/1/tickets").should route_to("tickets#index", :attendee_id => "1")
    end

    it "should nest emails" do
      get("/attendees/1/emails").should route_to("emails#index", :attendee_id => "1")
    end
  end
end
