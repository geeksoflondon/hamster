class Interaction < ActiveRecord::Base
  attr_accessible :interactable, :interactable_id, :interactable_type, :key, :value

  belongs_to :interactable, :polymorphic => true

  validates :interactable, presence: true
  validates :key, presence: true

  after_create :expire_previous_states

  serialize :value, JSON

  scope :search, ->(key, value, relation, ids){ where(key: key, value: value.to_json, current: true.to_json, interactable_type: relation.singularize.capitalize, interactable_id: ids) }

  protected

  def expire_previous_states
    previous_states.update_all(current: false)
  end

  def previous_states
    Interaction.where("interactable_id = ? AND interactable_type = ? AND key = ? AND id != ?", interactable_id, interactable_type, key, id)
  end
end
