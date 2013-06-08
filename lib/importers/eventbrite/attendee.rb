module Importers
  class Eventbrite
    class Attendee
      attr_accessor :first_name, :last_name, :email, :phone_number, :twitter, :tshirt, :diet, :eventbrite_xid

      def initialize data = {}
        data = data.with_indifferent_access
        self.first_name = data[:first_name]
        self.last_name = data[:last_name]
        self.email = data[:email]
        self.eventbrite_xid = data[:id].to_s

        data[:answers].each do |answer|
          case answer[:answer][:question]
            when "Twitter Username" then self.twitter = answer[:answer][:answer_text]
            when "T-Shirt Size" then self.tshirt = answer[:answer][:answer_text]
            when "Dietary Requirements" then self.diet = answer[:answer][:answer_text]
            when "A contact number" then self.phone_number = answer[:answer][:answer_text]
          end
        end
      end

      def imported?
        ::Ticket.find_by_eventbrite_xid(eventbrite_xid).present?
      end

      def import event
        return if imported?

        attendee = ::Attendee.create!({
          first_name: first_name,
          last_name: last_name,
          twitter: twitter,
          tshirt: tshirt_sizes[tshirt],
          diet: diets[diet],
          phone_number: phone_number,
          email: email
        })

        ::Ticket.create!({
          attendee: attendee,
          event: event,
          kind: 1,
          eventbrite_xid: eventbrite_xid
        })

        attendee
      end

      def diets
        {
          "Everything" => 1,
          "Vegetarian" => 2,
          "Vegan" => 3,
          "Nut Allergy" => 4,
          "Lactose Free" => 5,
          "Gluten Free" => 6,
          "Shellfish" => 7,
          "Other" => 8
        }
      end

      def tshirt_sizes
        {
          "Female Small" => 1,
          "Female Medium" => 2,
          "Female Large" => 3,
          "Male Small" => 4,
          "Male Medium" => 5,
          "Male Large" => 6,
          "Male Extra Large" => 7,
          "Male XXL" => 8
        }
      end

    end
  end
end