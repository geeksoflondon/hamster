class Ticket < ActiveRecord::Base
  include Interactable

  attr_accessible :attendee, :event, :kind, :eventbrite_xid

  belongs_to :attendee
  belongs_to :event
  has_many :interactions, as: :interactable

  validates :eventbrite_xid, presence: true, uniqueness: true
  validates :attendee_id, presence: true
  validates :event_id, presence: true, uniqueness: { scope: :attendee_id }
  validates :kind, presence: true, inclusion: { in: Ticket::Kind::TYPES }

  before_validation :set_kind
  after_create :generate_retain_token

  RETAIN_TOKEN = "retain_token".freeze

  def set_kind
    self.kind ||= Ticket::Kind::REGULAR
    true
  end

  def status
    return "Arrived" if self.is_arrived?
    return "Attending" if self.is_attending?
    return "Cancelled" if self.is_confirmed? && !self.is_attending?
    "Unconfirmed"
  end

  def badge
    case self.kind
    when 1..2
      "Attendee"
    when 3
      "VIP"
    when 4
      "Crew"
    when 5
      "Manager"
    end
  end

  def kinds
    {
      '1' => 'Attendee',
      '2' => 'Sponsor',
      '3' => 'VIP',
      '4' => 'Crew',
      '5' => 'Manager'
    }
  end

  private

  def generate_retain_token
    has RETAIN_TOKEN, SecureRandom.urlsafe_base64
  end

end
