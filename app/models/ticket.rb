class Ticket < ActiveRecord::Base
  include Interactable

  attr_accessible :attendee, :event, :kind

  belongs_to :attendee
  belongs_to :event
  has_many :interactions, as: :interactable

  validates :attendee_id, presence: true
  validates :event_id, presence: true, uniqueness: { scope: :attendee_id }
  validates :kind, presence: true, inclusion: { in: Ticket::Kind::TYPES }

  before_validation :set_kind

  after_create :generate_woodpecker_token

  def set_kind
    self.kind ||= Ticket::Kind::REGULAR
    true
  end

  def woodpecker_token
    get "woodpecker_token"
  end

  private

  def generate_woodpecker_token
    has "woodpecker_token", SecureRandom.urlsafe_base64
  end

end
