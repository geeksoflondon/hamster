require 'spec_helper'

describe TicketsController do

  it "should be an api controller" do
    TicketsController.new.should be_a(ApiController)
  end

end