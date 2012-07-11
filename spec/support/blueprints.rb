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
end

RSpec.configure do |config|
  prepare_object_factory

  Object.factory.clean_up

  config.after(:all) do
    Object.factory.clean_up
  end
end
