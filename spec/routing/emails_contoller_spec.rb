require "spec_helper"

describe EmailsController do
  describe "routing" do

    it "routes to #index" do
      get("/emails").should route_to("emails#index")
    end

    it "routes to #show" do
      get("/emails/1").should route_to("emails#show", :id => "1")
    end

    it "routes to #create" do
      post("/emails").should route_to("emails#create")
    end

    it "routes to #update" do
      put("/emails/1").should route_to("emails#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/emails/1").should route_to("emails#destroy", :id => "1")
    end

  end
end
