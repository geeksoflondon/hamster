class Ticket < ActiveRecord::Base
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
    self.interactions.where(:key => 'woodpecker_token').first['value']
  end

  private

  def generate_woodpecker_token
    o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
    token = Digest::SHA1.hexdigest("#{self.id}#{(0...50).map{ o[rand(o.length)] }.join}#{Time.now()}")
    self.interactions.create :key => 'woodpecker_token', :value => token
  end

end
