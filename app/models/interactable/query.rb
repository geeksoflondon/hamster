module Interactable
  class Query

    def initialize options
      self.klass = options[:klass]
      self.params = options[:params]

      initialize_query
      fetch_ids
      remove_interaction_params
    end

    def execute
      has_params ? klass.where("id IN (?)", matched_ids) : klass
    end

    protected

    attr_accessor :query, :params, :klass, :selected_ids, :rejected_ids, :has_params

    def initialize_query
      self.query = Interaction.where(interactable_type: klass.to_s)
    end

    def fetch_ids
      params.each do |key, value|
        fetch_ids_for(key, value) if key.starts_with? "interactions."
      end
    end

    def fetch_ids_for key, value
      self.has_params = true
      qr = query.where("key = ? AND value #{actual_comparator_for(key)} ?", actual_key_for(key), value)
      qr = qr.where("current = ?", true) if match_for_current? key
      ids = qr.pluck(:interactable_id)

      if comparator_for(key) == "!~"
        self.rejected_ids ||= []
        self.rejected_ids  += ids
        rejected_ids.uniq!
      elsif selected_ids.nil?
        self.selected_ids = ids
      else
        self.selected_ids = selected_ids & ids
      end
    end

    def comparator_for key
      key.split('.').last.split(" ").last
    end

    def actual_comparator_for key
      return "!=" if comparator_for(key) == "!="
      "="
    end

    def actual_key_for key
      key.split('.').last.split(" ").first
    end

    def match_for_current? key
      ["=", "!="].include? comparator_for(key)
    end

    def remove_interaction_params
      params.reject!{|key, value| key.starts_with?("interactions.")}
    end

    def matched_ids
      (selected_ids || []) - (rejected_ids || [])
    end
  end
end