module Hamster
  class Query

    def initialize options
      options = options.with_indifferent_access
      self.klass = options[:klass]
      self.params = options[:params].with_indifferent_access
      self.query = options[:klass]

      sanitize_params
      handle_interactions
      limit
      offset
      order
      build_query
    end

    def execute
      query
    end

    protected

    attr_accessor :query, :params, :klass

    def sanitize_params
      self.params = params.except(:action, :controller, :format)
    end

    def limit
      limit = params[:limit].to_i
      self.query = query.limit(limit) if params[:limit]
      params.delete(:limit)
    end

    def offset
      self.query = query.offset(params[:offset])
      params.delete(:offset)
    end

    def order
      order_by = params[:order] || "created_at DESC"
      self.query = query.order(order_by)
      params.delete(:order)
    end

    def handle_interactions
      if klass.reflect_on_all_associations.map(&:name).include? :interactions
        self.query = Interactable::Query.new(params: params, klass: klass).execute
      end
    end

    def build_query
      params.each do |option, value|
        self.query = query.where(query_params_for(option, value))
      end
    end

    def query_params_for option, value
      {option => value}
    end

    def table_name
      klass.to_s.downcase.pluralize
    end
  end
end