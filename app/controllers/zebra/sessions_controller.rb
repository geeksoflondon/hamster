#OnSite Registration Tool
class Zebra::SessionsController < ApplicationController

  before_filter :logged_in?, :except => [:index, :create]

  layout 'zebra'

  def index
    redirect_to :zebra_home_index if check_cookie(cookies[:zebra_token])
  end

  def create
    if check_cookie(params[:wristband]) === true
      login(params[:wristband])
      redirect_to :zebra_home_index
    else
      redirect_to :zebra_root
    end
  end

  def destroy
    logout
    redirect_to :zebra_root
  end

  private
  
  def logged_in?
    unless check_cookie(cookies[:zebra_token])
      redirect_to :zebra_sessions
    end
  end

  def login(wristband_id)
    wristband = get_wristband(wristband_id)
    cookies[:zebra_token] = params[:wristband]
    cookies[:zebra_event] = wristband.event_id
  end
  
  def logout
    cookies.delete :zebra_token
    cookies.delete :zebra_event
  end

  def get_wristband(wristband_id = nil)
    return false if wristband_id.nil?
    wristband = Wristband.find(wristband_id)
    return false unless wristband.present?
    wristband
  end

  def check_cookie(wristband_id = nil)
    wristband = get_wristband(wristband_id)
    return false if wristband == false
    Wristband.find(wristband_id).kind >= Ticket::Kind::CREW 
  end

end
