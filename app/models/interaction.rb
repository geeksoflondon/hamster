class Interaction < ActiveRecord::Base
  attr_accessible :interactable_id, :interactable_type, :key, :value

  belongs_to :interactable, :polymorphic => true

  validates :interactable, presence: true
  validates :key, presence: true
  validates :value, presence: true, allow_blank: true

  after_create :expire_previous_states

  protected

  def expire_previous_states
    Interaction.where("id != ? AND current = ?", id, true).update_all(current: false)
  end
end
