require 'spec_helper'

describe AttendeesController do

  it "should be an api controller" do
    AttendeesController.new.should be_a(ApiController)
  end

end