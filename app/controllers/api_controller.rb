class ApiController < ApplicationController
  http_basic_authenticate_with :name => Hamster::Config.get(:user), :password => Hamster::Config.get(:password)
  skip_before_filter :verify_authenticity_token

  def index
    limit = params[:limit]
    offset = params[:offset]
    filter = params.except(:limit, :offset, :action, :controller, :format)
    query = klass.limit(limit).offset(offset)
    filter.each do |option, value|
      query = query.where(option => value)
    end
    render json: query
  end

  def show
    result = klass.find(params[:id])
    render json: result
  end

  def create
    result = klass.new(params[param_name])

    if result.save
      render json: result, status: :created
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  def update
    result = klass.find(params[:id])

    if result.update_attributes(params[param_name])
      head :no_content
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  def destroy
    result = klass.find(params[:id])
    result.destroy

    head :no_content
  end

  def count
    render json: { id: "count", count: klass.count }
  end

  protected

  def klass
    self.class.name.gsub("Controller", "").singularize.constantize
  end

  def param_name
    self.class.name.gsub("Controller", "").singularize.downcase
  end

end