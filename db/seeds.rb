# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

attendee1 = Attendee.create!(first_name: "John", last_name: "Doe", public: true)
attendee2 = Attendee.create!(first_name: "Bob", last_name: "Example", public: true)
email1 = Email.create!(address: "john@example.com", attendee: attendee1)
email2 = Email.create!(address: "bob@example.com", attendee: attendee2)
ticket1 = Ticket.create!(event_id: 1, attendee: attendee1)
ticket2 = Ticket.create!(event_id: 2, attendee: attendee2)