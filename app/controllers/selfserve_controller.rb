class SelfserveController < ApplicationController

  layout "selfserve"
  
  def index
  end

  def create
    ticket = get_wristband(params[:wristband])
    redirect_to "/selfserve/#{ticket.id}" if ticket
    
    flash[:error] = "Wristbound not found"  if !ticket.present?
    redirect_to "/selfserve" if !ticket.present?
  end

  def show
    @ticket = Ticket.find(params[:id])
    status = @ticket.get 'onsite'
    
    @ticket.isnt 'onsite' if status == true
    @ticket.is 'onsite' if status == false

    @onsite = @ticket.get 'onsite'
  end

  private

  def get_wristband(wristband_id = nil)
    return false if wristband_id.blank?
    wristband = Wristband.find(wristband_id)
    return false unless wristband.present?
    wristband
  end
  
  def not_found
    flash[:notice] = "Wristband not found"
    redirect_to :selfserve
  end

end