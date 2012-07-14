require 'spec_helper'

describe EventsController do

  it "should be an api controller" do
    EventsController.new.should be_a(ApiController)
  end

end