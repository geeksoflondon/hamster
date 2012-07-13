class Ticket < ActiveRecord::Base
  attr_accessible :attendee, :event_id

  validates :attendee_id, presence: true
  validates :event_id, presence: true, uniqueness: { scope: :attendee_id }

  belongs_to :attendee
end