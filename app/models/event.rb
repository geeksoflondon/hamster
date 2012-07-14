class Event < ActiveRecord::Base

  @url_regex = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix

  attr_accessible :name, :url, :start_date, :end_date, :eventbrite_xid

  validates :name, presence: true
  validates :url, allow_nil: true, allow_blank: true, format: { with: @url_regex }
  validates :start_date, presence: true
  validates :end_date, presence: true

  validates_date :start_date, :before => :end_date
  validates_date :end_date, :after => :start_date

  before_validation :sanitize_name

  protected

  def sanitize_name
    self.name = "#{name.to_s.strip}"
    true
  end

end