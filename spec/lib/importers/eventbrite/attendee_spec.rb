require 'spec_helper'
require 'importers/eventbrite'

describe Importers::Eventbrite::Attendee do
  before :each do
    params = {
      first_name: "Alpha",
      last_name: "Beta",
      email: "alpha@beta.com",
      id: 1234567,
      answers: [
        {"answer"=>{"answer_text"=>"@alphabeta", "question"=>"Twitter Username", "question_type"=>"text", "question_id"=>111}},
        {"answer"=>{"answer_text"=>"123456789", "question"=>"A contact number", "question_type"=>"text", "question_id"=>222}},
        {"answer"=>{"answer_text"=>"Male Large", "question"=>"T-Shirt Size", "question_type"=>"multiple choice", "question_id"=>333}},
        {"answer"=>{"answer_text"=>"Everything", "question"=>"Dietary Requirements", "question_type"=>"multiple choice", "question_id"=>444}}
      ]
    }
    @attendee = Importers::Eventbrite::Attendee.new params
    @event = a_saved Event, eventbrite_xid: "99999999"
  end

  describe "#imported?" do
    it "should return true if already imported" do
      a_saved Ticket, eventbrite_xid: "1234567"
      @attendee.imported?.should be_true
    end

    it "should return false if not already imported" do
      @attendee.imported?.should_not be_true
    end
  end

  describe "#import" do
    it "should do nothing if the attendee was already imported" do
      a_saved Ticket, eventbrite_xid: "1234567"

      ::Attendee.count.should be == 1
      ::Ticket.count.should be == 1

      @attendee.import @event

      ::Attendee.count.should be == 1
      ::Ticket.count.should be == 1

    end

    it "should import an unimported attendee" do
      ::Attendee.count.should be == 0
      ::Ticket.count.should be == 0

      @attendee.import @event

      @attendee.should be_imported
      ::Attendee.count.should be == 1
      ::Ticket.count.should be == 1
    end
  end
end