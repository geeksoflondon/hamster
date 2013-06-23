# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require "rujitsu"

#Venue
venue = Venue.create!(:name => 'London Zoo', :address => 'Regents Park', :description => 'Come see the zoo')

#Past event
event1 = Event.create!(
  :name => "#{Faker::Name.first_name}'s' Tea Party",
  :url => 'http://bit.ly/teaparty',
  :venue => venue,
  :start_date => Time.now - 7.days,
  :end_date => Time.now - 6.days,
  :eventbrite_xid => "123456"
)

#Upcoming event
event2 = Event.create!(
  :name => "#{Faker::Name.first_name}'s' Tea Party",
  :url => 'http://bit.ly/teaparty',
  :venue => venue,
  :start_date => Time.now + 5.days,
  :end_date => Time.now + 6.days,
  :eventbrite_xid => "654321"
)

(1..100).each do

  #Generate a attendee
  attendee = Attendee.create!({
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    twitter: Faker::Internet.user_name,
    is_public: true,
    tshirt: rand(1..8),
    email: Faker::Internet.email
  }, :without_protection => true)

  #Setup a ticket for the previous week's event
  ticket = Ticket.create!(:attendee => attendee, :event => event1, :eventbrite_xid => 10.random_numbers)
  ticket.interactions.create!(:key => 'confirmed', :value => [true, false].sample)
  ticket.interactions.create!(:key => 'cancelled', :value => [true, false].sample)
  ticket.interactions.create!(:key => 'arrived', :value => [true, false].sample)

  ticket = Ticket.create!(:attendee => attendee, :event => event2, :eventbrite_xid => 10.random_numbers)
  ticket.interactions.create!(:key => 'confirmed', :value => [true, false].sample)
  ticket.interactions.create!(:key => 'cancelled', :value => [true, false].sample)
end
