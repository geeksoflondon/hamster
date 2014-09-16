require 'colorize'
require 'createsend'

namespace :campaign_monitor do
  desc "Update BarCamp Berkshire"
  task :update_event => :environment do
    CreateSend.api_key ENV["CM_KEY"]
    event = Event.find(3)
    event.tickets.each do |ticket|
      a = ticket.attendee

      params = [
        {:Key => 'has_ticket', :Value => 'true'},
        {:Key => 'status', :Value => ticket.is_confirmed?.to_s},
        {:Key => 'attending', :Value => ticket.is_attending?.to_s},
        {:Key => 'arrived', :Value => ticket.is_arrived?.to_s},
        {:Key => 'token', :Value => ticket.get(Ticket::RETAIN_TOKEN)}
        ]

      CreateSend::Subscriber.add "d3e3ae2b0ab572bce8be82ff43edb90b", a.email, a.name, params, true
    end
  end
end
