require 'spec_helper'

describe InteractionsController do

  it "should be an api controller" do
    InteractionsController.new.should be_a(ApiController)
  end
end