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
      event_id: -> { 1.random_number },
      attendee: -> { a_saved Attendee }
    }

  Object.factory.when_creating_a Event,
    clean_up: true,
    set: {
      name: "Ultimate Band Camp",
      url: "http://www.ultimatecamp.co.uk/",
      start_date: "01/01/1900",
      end_date: "02/01/1900"
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
end

RSpec.configure do |config|
  prepare_object_factory

  Object.factory.clean_up

  config.after(:all) do
    Object.factory.clean_up
  end
end
