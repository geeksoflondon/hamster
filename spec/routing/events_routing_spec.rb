require "spec_helper"

describe EventsController do
  describe "routing" do

    it "routes to #index" do
      get("/events").should route_to("events#index")
    end

    it "routes to #show" do
      get("/events/1").should route_to("events#show", :id => "1")
    end

    it "routes to #create" do
      post("/events").should route_to("events#create")
    end

    it "routes to #update" do
      put("/events/1").should route_to("events#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/events/1").should route_to("events#destroy", :id => "1")
    end

  end
end
