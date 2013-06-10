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
end