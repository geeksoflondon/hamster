class Email < ActiveRecord::Base
  attr_accessible :address, :attendee

  validates :address, presence: true
  validates :attendee, presence: true

  belongs_to :attendee
end