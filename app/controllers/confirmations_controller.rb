class ConfirmationsController < ApplicationController
  before_filter :ensure_ticket_present, only: [:edit, :update, :show]

  layout "confirmations"

  def index
  end

  def show
    redirect_to confirmations if params[:id].nil?
  end

  def edit
  end

  def update
    if @confirmation.save(params)
      redirect_to :confirmation, id: @confirmation.token
    else
      render :edit
    end
  end

  private

  def ensure_ticket_present
    redirect_to :confirmations if ticket.nil?
    @confirmation = Ticket::Confirmation.new(ticket)
    @attendee = ticket.attendee
    @event = ticket.event
  end

  def ticket
    @_ticket ||= Ticket.get(Ticket::RETAIN_TOKEN, params[:id])
  end

end