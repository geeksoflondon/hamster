module Interactable
  class Query

    def initialize options
      self.klass = options[:klass]
      self.params = options[:params]

      initialize_query
      fetch_ids
      remove_interactions_params
    end

    def execute
      selected_ids.nil? ? klass : klass.where("id IN (?)", selected_ids)
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
      case comparator_for(key)
      when "="
        ids = query.where("key = ? AND value = ? AND current = ?", actual_key_for(key), value, true).pluck(:interactable_id)
        select(ids)
      when "!="
        ids = query.where("key = ? AND value != ? AND current = ?", actual_key_for(key), value, true).pluck(:interactable_id)
        select(ids)
      when "~"
        ids = query.where("key = ? AND value = ?", actual_key_for(key), value).pluck(:interactable_id)
        select(ids)
      when "!~"
        ids = klass.pluck(:id) - query.where("key = ? AND value = ?", actual_key_for(key), value).pluck(:interactable_id)
        select(ids)
      end
    end

    def comparator_for key
      key.split('.').last.split(" ").last
    end

    def actual_key_for key
      key.split('.').last.split(" ").first
    end

    def match_for_current? key
      ["=", "!="].include? comparator_for(key)
    end

    def remove_interactions_params
      params.reject!{|key, value| key.starts_with?("interactions.")}
    end

    def select ids
      selected_ids.nil? ? self.selected_ids = ids : self.selected_ids = ids & selected_ids
    end

    def reject ids
      self.rejected_ids
      self.rejected_ids -= rejected_ids
    end
  end
end