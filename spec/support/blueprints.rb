def prepare_object_factory
  Object.factory.reset

  Object.factory.when_creating_a Attendee,
    clean_up: true,
    set: {
      first_name: "John"
    },
    generate: {
      last_name: -> { 4.random_letters }
    }

  Object.factory.when_creating_a Email,
    clean_up: true,
    generate: {
      address: -> { "john@#{5.random.letters}.com" },
      attendee: -> { a_saved Attendee }
    }

  Object.factory.when_creating_a Ticket,
    clean_up: true,
    generate: {
      event: -> { a_saved Event },
      attendee: -> { a_saved Attendee },
      eventbrite_xid: -> { "#{8.random_numbers}" }
    }

  Object.factory.when_creating_a Event,
    clean_up: true,
    set: {
      name: "Ultimate Band Camp",
      url: "http://www.ultimatecamp.co.uk/",
      start_date: "01/01/1900",
      end_date: "02/01/1900"
    },
    generate: {
      venue: -> { a_saved Venue },
      eventbrite_xid: -> { "#{8.random_numbers}" }
    }

  Object.factory.when_creating_a Interaction,
    clean_up: true,
    set: {
      key: "foo",
      value: "bar"
    },
    generate: {
      interactable: -> { a_saved Attendee }
    }

  Object.factory.when_creating_a Venue,
    clean_up: true,
    generate: {
      address: -> { "123 #{5.random_letters} street, London, UK" },
      name: -> { "#{5.random_letters} plaza" },
      description: -> { "Cras mattis consectetur purus sit amet fermentum. Donec id elit non mi porta gravida at eget metus." }
    }
end

RSpec.configure do |config|
  prepare_object_factory

  Object.factory.clean_up

  config.after(:all) do
    Object.factory.clean_up
  end
end
