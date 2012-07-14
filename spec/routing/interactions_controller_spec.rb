require "spec_helper"

describe InteractionsController do
  describe "routing" do

    it "routes to #index" do
      get("/interactions").should route_to("interactions#index")
    end

    it "routes to #show" do
      get("/interactions/1").should route_to("interactions#show", :id => "1")
    end

    it "routes to #create" do
      post("/interactions").should route_to("interactions#create")
    end

    it "routes to #update" do
      put("/interactions/1").should route_to("interactions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/interactions/1").should route_to("interactions#destroy", :id => "1")
    end

  end
end
