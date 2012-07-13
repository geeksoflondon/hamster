class Interaction < ActiveRecord::Base
  attr_accessible :interactable, :key, :value

  belongs_to :interactable, :polymorphic => true

  validates :interactable, presence: true
  validates :key, presence: true
  validates :value, presence: true, allow_blank: true

  def value
    return true if value == "true"
    return false if value == "false"
    value
  end
end
