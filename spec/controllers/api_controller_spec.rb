require 'spec_helper'

describe AttendeesController do

  describe "GET index" do
    it { should_authenticate :get, :index, 200 }

    context "when logged in" do
      before :each do
        @attendees = Array.new(3) { a_saved Attendee }
      end

      it "should return all attendees" do
        authenticate
        get :index
        result = JSON.parse(response.body)
        result.should have(3).attendees
        result.each do |attendee|
          attendee.should be_a(Hash)
        end
      end

      it "should take a limit" do
        authenticate
        get :index, limit: 1
        result = JSON.parse(response.body)
        result.should have(1).attendee
      end

      it "should take a offset" do
        authenticate
        get :index, offset: 1
        result = JSON.parse(response.body)
        result.should have(2).attendees
      end

      it "should use other params as filters" do
        authenticate
        get :index, last_name: @attendees.first.last_name
        result = JSON.parse(response.body)
        result.should have(1).attendee
        result.first["last_name"].should be == @attendees.first.last_name
      end
    end
  end

  describe "GET show" do
    before :each do
      @attendee = a_saved Attendee
    end

    it { should_authenticate :get, :show, 200, id: @attendee.id }

    context "when logged in" do
      it "should return the attendee" do
        authenticate
        get :show, id: @attendee.id
        result = JSON.parse(response.body)
        result["id"].should be == @attendee.id
      end
    end
  end

  describe "POST create" do
    it { should_authenticate :post, :create, 422 }

    describe "with valid params" do
      before :each do
        @valid_attributes = { first_name: "John" }
      end

      it "creates a new Attendee" do
        expect {
          authenticate
          post :create, attendee: @valid_attributes
        }.to change(Attendee, :count).by(1)
      end

      it "should render the newly created attendee" do
        authenticate
        post :create, attendee: @valid_attributes
        result = JSON.parse(response.body)
        result["id"].should be == Attendee.last.id
      end
    end

    describe "with invalid params" do
      it "should return the errors" do
        authenticate
        post :create, attendee: {}
        result = JSON.parse(response.body)
        result.should be_a(Hash)
      end

      it "should return a error status" do
        authenticate
        post :create, attendee: {}
        response.status.should be(422)
      end
    end
  end

  describe "PUT update" do
    before :each do
      @attendee = a_saved Attendee
    end

    it { should_authenticate :put, :update, 204, id: @attendee.id }

    describe "with valid params" do
      before :each do
        @params = {first_name: "Moby"}
      end

      it "updates the requested attendee" do
        authenticate
        put :update, id: @attendee.id, attendee: @params
        @attendee.reload.first_name.should be == "Moby"
      end

      it "should render nothing" do
        authenticate
        put :update, id: @attendee.id, attendee: @params
        response.body.should be_blank
      end
    end

    describe "with invalid params" do
      before :each do
        @params = {first_name: nil, last_name: nil}
      end

      it "should return the errors" do
        authenticate
        put :update, id: @attendee.id, attendee: @params
        result = JSON.parse(response.body)
        result.should be_a(Hash)
      end

      it "should return a error status" do
        authenticate
        post :update, id: @attendee.id, attendee: @params
        response.status.should be(422)
      end
    end
  end


  describe "DELETE destroy" do
    before :each do
      @attendee = a_saved Attendee
    end

    it { should_authenticate :delete, :destroy, 204, id: @attendee.id }

    it "destroys the requested attendee" do
      expect {
        authenticate
        delete :destroy, id: @attendee.id
      }.to change(Attendee, :count).by(-1)
    end
  end

  protected

  def should_authenticate verb, action, success_code, params = {}
    self.send(verb, action, params)
    response.status.should be(401)

    authenticate
    self.send(verb, action, params)
    response.status.should be(success_code)
  end
end
