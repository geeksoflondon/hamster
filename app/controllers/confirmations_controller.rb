class ConfirmationsController < ApplicationController
  before_filter :ensure_confirmation_loaded, only: [:edit, :update, :show]

  layout "confirmations"

  def edit
  end

  def update
    if Ticket::Confirmation.new(ticket).save(params)
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

  def ensure_confirmation_loaded
    redirect_to :confirmations if confirmation.nil?
  end

  def confirmation
    @confirmation ||= ticket.nil? ? nil : Ticket::Confirmation.new(ticket)
  end

  def ticket
    @ticket ||= interaction.try(:interactable)

  end

  def interaction
    @interaction ||= Interaction.where(:key => 'woodpecker_token', :value => params[:id], :current => true).first
  end
end