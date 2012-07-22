require 'spec_helper'

describe VenuesController do

  it "should be an api controller" do
    VenuesController.new.should be_a(ApiController)
  end

end