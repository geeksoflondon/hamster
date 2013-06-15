class SelfservesController < ApplicationController

  layout "confirmations"

  def show
  end

  def edit
  end

  def update
    
    wristband = get_wristband(params[:wristband])
    not_found unless wristband
    
    wristband.is 'onsite' if params[:direction] == 'onsite'
    wristband.isnt 'onsite' if params[:direction] == 'offsite'

    wristband.is 'returning' if params[:returning] == 'true'
    wristband.isnt 'returning' if params[:returning] == 'false'

    redirect_to :edit_selfserve
  end
  
  private

  def get_wristband(wristband_id = nil)
    return false if wristband_id.nil?
    wristband = Wristband.find(wristband_id)
    return false unless wristband.present?
    wristband
  end
  
  def not_found
    flash[:notice] = "Wristband not found"
    redirect_to :selfserve
  end

end