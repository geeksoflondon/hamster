class ApiController < ApplicationController

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
    @klass = klass.find(params[:id])
    render json: @klass
  end

  def create
    @klass = klass.new(params[:klass])

    if @klass.save
      render json: @klass, status: :created, location: @klass
    else
      render json: @klass.errors, status: :unprocessable_entity
    end
  end

  def update
    @klass = klass.find(params[:id])

    if @klass.update_attributes(params[:klass])
      head :no_content
    else
      render json: @klass.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @klass = klass.find(params[:id])
    @klass.destroy

    head :no_content
  end

  def count
    render json: { id: "count", count: klass.count }
  end

  protected

  def klass
    self.class.name.gsub("Controller", "").singularize.constantize
  end

end