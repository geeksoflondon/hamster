class Ticket < ActiveRecord::Base
  attr_accessible :attendee, :attendee_id, :event_id, :created_at, :updated_at

  validates :attendee_id, presence: true
  validates :event_id, presence: true, uniqueness: { scope: :attendee_id }

  belongs_to :attendee
  belongs_to :event
  has_many :interactions, as: :interactable
end
