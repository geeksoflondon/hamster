#OnSite Registration Tool
class Zebra::ZebraController < ApplicationController
  
  before_filter :logged_in?, :except => [:index, :login]
  
  layout 'zebra'
  
  def index
  end
  
  def login
    if check_token(params[:wristband]) === true
      cookies[:zebra_token] = params[:wristband]
      redirect_to :zebra_home
    else
      redirect_to :zebra_index
    end
  end
  
  def logout
  end
  
  def help
  end

  private
  
  def logged_in?
    unless check_token(cookies[:zebra_token])
      redirect_to :zebra_index
    end
  end

  def check_token(token = '')
    token = Interaction.where(
        :interactable_type => 'Ticket',
        :key => 'wristband', 
        :value => token,
        :current => true)

    return false if token.empty?

    ticket = token.first.interactable

    unless ticket.kind == Ticket::Kind::CREW
      return false
    else
      return true
    end
  
  end

end