class Event < ActiveRecord::Base

  @url_regex = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix

  attr_accessible :name, :url, :start_date, :end_date, :eventbrite_xid

  validates :name, presence: true
  validates :url, allow_nil: true, allow_blank: true, format: { with: @url_regex }
  validates :start_date, presence: true
  validates :end_date, presence: true

  before_validation :sanitize_name
  before_validation :valid_start_date?, :valid_end_date?
  before_validation :start_before_end?, :end_after_start?

  protected

  def sanitize_name
    self.name = "#{name.to_s.strip}"
    true
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