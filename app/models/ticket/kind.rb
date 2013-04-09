class Ticket
  class Kind
    REGULAR = 1.freeze
    CREW =    2.freeze
    VIP =     3.freeze
    VENUE =   4.freeze
    SPONSOR = 5.freeze

    TYPES = (1..5).freeze
  end
end