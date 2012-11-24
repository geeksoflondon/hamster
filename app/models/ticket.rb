class Ticket < ActiveRecord::Base
  attr_accessible :attendee, :event

  belongs_to :attendee
  belongs_to :event
  has_many :interactions, as: :interactable

  validates :attendee_id, presence: true
  validates :event_id, presence: true, uniqueness: { scope: :attendee_id }
end
