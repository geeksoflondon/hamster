class Ticket < ActiveRecord::Base
  attr_accessible :attendee, :event, :kind

  belongs_to :attendee
  belongs_to :event
  has_many :interactions, as: :interactable

  validates :attendee_id, presence: true
  validates :event_id, presence: true, uniqueness: { scope: :attendee_id }
  validates :kind, presence: true, inclusion: { in: Ticket::Kind::TYPES }

  before_validation :set_kind

  def set_kind
    self.kind ||= Ticket::Kind::REGULAR
    true
  end

end
