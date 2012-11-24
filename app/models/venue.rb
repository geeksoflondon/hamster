class Venue < ActiveRecord::Base
  attr_accessible :name, :address, :description

  has_many :events

  validates :name, uniqueness: true, presence: true
end
