class ConfirmationsController < ApplicationController
  before_filter :ensure_ticket_present, only: [:edit, :update, :show]

  layout "confirmations"

  def edit
  end

  def update
    if @ticket.save(params)
      redirect_to :confirmation, id: @ticket.token
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
    @ticket = Ticket::Confirmation.new(ticket)
  end

  def ticket
    @_ticket ||= Ticket.get(Ticket::RETAIN_TOKEN, params[:id])
  end
end