require "spec_helper"

describe TuilesController do
  describe "routing" do

    it "routes to #index" do
      get("/tuiles").should route_to("tuiles#index")
    end

    it "routes to #new" do
      get("/tuiles/new").should route_to("tuiles#new")
    end

    it "routes to #show" do
      get("/tuiles/1").should route_to("tuiles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tuiles/1/edit").should route_to("tuiles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tuiles").should route_to("tuiles#create")
    end

    it "routes to #update" do
      put("/tuiles/1").should route_to("tuiles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tuiles/1").should route_to("tuiles#destroy", :id => "1")
    end

  end
end
