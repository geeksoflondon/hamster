module Interactable
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def get key, value
      Interaction.where(key: key, value: value, current: true).first
    end

    def interactable key, value
      get(key, value).try(:interactable)
    end
  end

  def method_missing(meth, *args, &block)
    if meth.to_s =~ /^is_(.+)\?$/
      check_boolean_interactable($1, *args, &block)
    elsif meth.to_s =~ /^is_(.+)!$/
      is $1
    elsif meth.to_s =~ /^isnt_(.+)!$/
      isnt $1
    elsif meth.to_s =~ /^has_(.+)\?$/
      check_length_interactable($1, *args, &block)
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

  def check_boolean_interactable key, *args, &block
    get(key) === "true"
  end

  def check_length_interactable key, *args, &block
    interactions.where(key: key).count > 0
  end
end