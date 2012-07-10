class Attendee < ActiveRecord::Base
  attr_accessible :diet, :first_name, :last_name, :phone_number, :public, :tshirt, :twitter

  has_many :emails
end
