class Attendee < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :twitter, :address, :tshirt

  has_many :emails
  has_many :tickets
  has_many :interactions, as: :interactable

  validates :name, presence: true, allow_blank: false
  validates :tshirt, allow_nil: true, inclusion: { in: Attendee::Tshirt::SIZES }
  validates :kind, presence: true, inclusion: { in: Attendee::Kind::TYPES }
  validates :is_public, inclusion: { in: [true, false] }

  before_validation :cleanup_twitter
  before_validation :set_name
  before_validation :set_kind

  private

  def set_name
    self.name = "#{first_name.to_s.strip} #{last_name.to_s.strip}"
    true
  end

  def set_kind
    self.kind ||= Attendee::Kind::REGULAR
    true
  end

  def cleanup_twitter
    self.twitter = twitter ? twitter.gsub("@", "") : nil
    true
  end
end
