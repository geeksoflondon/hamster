require 'spec_helper'

describe EmailsController do

  it "should be an api controller" do
    EmailsController.new.should be_a(ApiController)
  end

end