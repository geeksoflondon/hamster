class ConfirmationsController < ApplicationController
  before_filter :ensure_ticket_present, only: [:edit, :update, :show]

  layout "confirmations"

  def edit
  end

  def update
    if @confirmation.save(params)
      redirect_to :confirmation, id: ticket.woodpecker_token
    else
      render :edit
    end
  end

  def show
  end

  def index
  end

  private

  def ensure_ticket_present
    redirect_to :confirmations if ticket.nil?
    @confirmation = Ticket::Confirmation.new(ticket)
  end

  def ticket
    @ticket ||= Ticket.get("woodpecker_token", params[:id])
  end
end