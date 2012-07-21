module Interactable
  class Query

    def initialize options
      self.klass = options[:klass]
      self.params = options[:params]
      initialize_query
      fetch_ids
    end

    def execute
      ids.nil? ? klass : klass.where("id IN (?)", ids)
    end

    protected

    attr_accessor :query, :params, :klass, :ids

    def initialize_query
      self.query = Interaction.where(interactable_type: klass.to_s)
    end

    def fetch_ids
      params.each do |key, value|
        fetch_ids_for(key, value) if key.starts_with? "interactions."
      end
    end

    def fetch_ids_for key, value
      qr = query.where("interactions.key = ? AND interactions.value #{actual_comparator_for(key)} ?", actual_key_for(key), value)
      qr = qr.where("interactions.current = ?", true) if match_for_current? key
      selected_ids = qr.pluck(:interactable_id)
      ids.nil? ? self.ids = selected_ids : self.ids = ids & selected_ids
    end

    def comparator_for key
      key.split('.').last.split(" ").last
    end

    def actual_comparator_for key
      comparator_for(key).starts_with?("!") ? "!=" : "="
    end

    def actual_key_for key
      key.split('.').last.split(" ").first
    end

    def match_for_current? key
      ["=", "!="].include? comparator_for(key)
    end
  end
end