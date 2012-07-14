class Event < ActiveRecord::Base
  attr_accessible :name, :url, :start_date, :end_date, :eventbrite_xid

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  before_validation :set_name
  before_validation :valid_url?
  before_validation :valid_start_date?, :valid_end_date?
  before_validation :start_before_end?, :end_after_start?

  protected

  def set_name
    self.name = "#{name.to_s.strip}"
    true
  end

  def valid_url?
    valid = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix.match(self.url)
    raise(ArgumentError, "A URL must be correctly formatted for example http://bbc.co.uk/") unless valid || self.url.nil?
  end

  def valid_start_date?
    self.start_date.is_a? ActiveSupport::TimeWithZone
  end

  def valid_end_date?
    self.end_date.is_a? ActiveSupport::TimeWithZone
  end

  def start_before_end?
    raise(ArgumentError, "Start must be before end") unless self.end_date > self.start_date
  end

  def end_after_start?
    raise(ArgumentError, "End must be after start") unless self.start_date < self.end_date
  end

end