require 'colorize'
require 'createsend'

namespace :campaign_monitor do
  desc "Update BarCamp Berkshire"
  task :update_event => :environment do
    CreateSend.api_key ENV["CM_KEY"]
    event = Event.where(:name => 'HACKED').first
    event.tickets.each do |ticket|
      a = ticket.attendee
    
      params = [
        {:Key => 'has_ticket', :Value => 'true'},
        {:Key => 'status', :Value => ticket.is_confirmed?.to_s},
        {:Key => 'attending', :Value => ticket.is_attending?.to_s},
        {:Key => 'arrived', :Value => ticket.is_arrived?.to_s},
        {:Key => 'token', :Value => ticket.get(Ticket::RETAIN_TOKEN)}
        ]
      
      CreateSend::Subscriber.add "94ce8cb97a1d9e2fb67741369f2466fc", a.email, a.name, params, true
    end
  end
end