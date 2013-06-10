require 'colorize'
require 'createsend'

namespace :campaign_monitor do
  desc "Update BarCamp Berkshire"
  task :update_event => :environment do
    CreateSend.api_key ENV["CM_KEY"]
    event = Event.where(:name => 'BarCamp Berkshire 2').first
    event.tickets.each do |ticket|
      a = ticket.attendee
    
      params = [
        {:Key => 'status', :Value => ticket.is_confirmed?.to_s},
        {:Key => 'attending', :Value => ticket.is_attending?.to_s},
        {:Key => 'token', :Value => ticket.is_attending?.to_s}
        ]
      
      CreateSend::Subscriber.add "eec576f40dcab219a336a98646e3faad", a.email, a.name, params, true
    end
  end
end