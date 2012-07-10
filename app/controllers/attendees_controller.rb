class AttendeesController < ApplicationController

  def index
    @attendees = Attendee.all
    render json: @attendees
  end

  def show
    @attendee = Attendee.find(params[:id])
    render json: @attendee
  end

  def create
    @attendee = Attendee.new(params[:attendee])

    if @attendee.save
      render json: @attendee, status: :created, location: @attendee
    else
      render json: @attendee.errors, status: :unprocessable_entity
    end
  end

  def update
    @attendee = Attendee.find(params[:id])

    if @attendee.update_attributes(params[:attendee])
      head :no_content
    else
      render json: @attendee.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @attendee = Attendee.find(params[:id])
    @attendee.destroy

    head :no_content
  end
end
