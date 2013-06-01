class Ticket
  class Kind
    REGULAR = 1.freeze
    SPONSOR = 2.freeze
    VIP =     3.freeze
    CREW =    4.freeze
    MANAGER = 5.freeze

    TYPES = (1..5).freeze
  end
end