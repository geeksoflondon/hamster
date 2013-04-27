class Attendee < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :twitter, :tshirt, :diet, :phone_number, :email

  has_many :tickets
  has_many :interactions, as: :interactable

  validates :name, presence: true, allow_blank: false
  validates :tshirt, allow_nil: true , inclusion: { in: Attendee::Tshirt::SIZES }
  validates :diet, allow_nil: true , inclusion: { in: Attendee::Diet::TYPES }
  validates :is_public, inclusion: { in: [true, false] }

  before_validation :cleanup_twitter
  before_validation :set_name

  private

  def set_name
    self.name = "#{first_name.to_s.strip} #{last_name.to_s.strip}"
    true
  end

  def cleanup_twitter
    self.twitter = twitter ? twitter.gsub(/[^a-zA-Z0-9_]*/, "") : nil
    true
  end
end
