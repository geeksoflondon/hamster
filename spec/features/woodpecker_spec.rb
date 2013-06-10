require 'spec_helper'

describe "the signup process", :type => :feature do

  before :each do
    @ticket = a_saved Ticket
    @retain_token = @ticket.get(Ticket::RETAIN_TOKEN)
  end

  it "i confirm my ticket" do
    visit "/confirmations/#{@retain_token}/edit"
    find("#attending").set "true"
    click_on "I am attending!"
    page.should have_content "Check what's on your badge"
    click_on "Next..."
    click_on "Save my details"
    @ticket.reload
    @ticket.is_confirmed?.should == true
    @ticket.is_attending?.should == true
  end

  it "i cancel my ticket" do
    visit "/confirmations/#{@retain_token}/edit"
    find("#attending").set "false"
    page.should have_content "Hello, #{@ticket.attendee.first_name}  #{@ticket.attendee.last_name}"
    click_on "Cancel my ticket!"
    page.should have_content "#{@ticket.attendee.first_name}, are you sure you want to cancel?"
    click_on "Yes, cancel my ticket."
    @ticket.reload
    @ticket.is_confirmed?.should == true
    @ticket.is_attending?.should == false
  end

end