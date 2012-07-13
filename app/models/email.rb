class Email < ActiveRecord::Base
  attr_accessible :address, :attendee

  validates :address, presence: true, uniqueness: { scope: :attendee_id }
  validates :attendee, presence: true

  belongs_to :attendee
end