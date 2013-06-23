module Interactable
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def interaction key, value
      interactions(key, value).first
    end

    def interactions key, value
      Interaction.where(key: key, value: value.to_json, current: true, interactable_type: self.name)
    end

    def get key, value
      interaction(key, value).try(:interactable)
    end

    def get_all key, value
      interactions(key, value).map{|int| int.interactable }
    end
  end

  def method_missing(meth, *args, &block)
    if meth.to_s =~ /^is_(.+)\?$/
      check_boolean_interactable($1)
    elsif meth.to_s =~ /^is_(.+)!$/
      is $1
    elsif meth.to_s =~ /^isnt_(.+)!$/
      isnt $1
    elsif meth.to_s =~ /^has_(.+)\?$/
      check_length_interactable($1)
    elsif meth.to_s =~ /^all_([a-z]+)_counts$/
      count_all_for $1
    elsif meth.to_s =~ /^([a-z_]+)_([a-z]+)_count$/
      count_combined_interaction_relations $1.split("_and_"), $2
    else
      super
    end
  end

  def is key
    has key, true
  end

  def isnt key
    has key, false
  end

  def has key, value
    interactions.create(key: key, value: value)
  end

  def get key
    interactions.where(key: key, current: true).first.try(:value)
  end

  private

  def check_boolean_interactable key
    get(key) == true
  end

  def check_length_interactable key
    interactions.where(key: key).count > 0
  end

  def count_all_for relation
    relation_ids = send(relation).pluck(:id)
    results = Interaction.where(interactable_id: relation_ids, current: true.to_s, value: true.to_s).pluck(:key)
    results.inject(Hash.new(0)){|h,k| h[k] += 1; h}
  end

  def count_combined_interaction_relations interactions, relation
    relation_ids = send(relation).pluck(:id)
    interactions.each do |interaction|
      value = true
      if interaction.starts_with? "not_"
        interaction = interaction.gsub("not_", "")
        value = false
      end
      relation_ids &= Interaction.search(interaction, value, relation, relation_ids).pluck(:interactable_id).uniq
    end
    relation_ids.count
  end
end