require 'spec_helper'

describe OnsiteregController do

  describe "without a valid token" do
    it "#index" do
      get :index
      expect(response).to be_success
    end
    
    it "#show" do
      get :show
      expect(response).to be_redirect
    end
    
    it "#edit" do
      get :edit
      expect(response).to be_redirect
    end
    
    it "#new" do
      get :new
      expect(response).to be_redirect
    end
    
  end

end
