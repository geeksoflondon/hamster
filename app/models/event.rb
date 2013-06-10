class Event < ActiveRecord::Base
  include Interactable

  @url_regex = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix

  attr_accessible :name, :url, :venue, :start_date, :end_date, :eventbrite_xid

  validates :name, presence: true
  validates :url, allow_nil: true, allow_blank: true, format: { with: @url_regex }
  validates :start_date, presence: true
  validates :end_date, presence: true

  validates_date :start_date, :on_or_before => :end_date

  before_validation :sanitize_name

  has_many :tickets
  has_many :interactions, as: :interactable
  has_many :attendees, through: :tickets
  belongs_to :venue

  def english_date
    event_length = (self.end_date - self.start_date).to_i
    unless event_length > 0
      "on #{self.start_date.to_formatted_s(:long_ordinal)}"
    else
      "from #{self.start_date.to_formatted_s(:long_ordinal)} to #{self.end_date.to_formatted_s(:long_ordinal)}"
    end
  end

  protected

  def sanitize_name
    self.name = "#{name.to_s.strip}"
    true
  end
  
end
