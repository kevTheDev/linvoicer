require "spec_helper"

describe ClientsController do
  describe "routing" do

    it { get("/").should                route_to("clients#index") }
    it { get("/clients").should         route_to("clients#index") }
    it { get("/clients/1").should       route_to("clients#show", id: '1') }
    it { get("/clients/new").should     route_to("clients#new") }
    it { post("/clients").should        route_to("clients#create") }
    it { get("/clients/1/edit").should  route_to("clients#edit", id: '1') }
    it { put("/clients/1").should       route_to("clients#update", id: '1') }
    it { delete("/clients/1").should    route_to("clients#destroy", id: '1') }

  end
end
