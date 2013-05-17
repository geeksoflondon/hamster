#OnSite Registration Tool
class Zebra::SessionsController < ApplicationController

  before_filter :logged_in?, :except => [:index, :new, :create]

  layout 'zebra'

  def index
  end

  def show
    render :text => 'success'
  end

  def create
    if check_token(params[:wristband]) === true
      cookies[:zebra_token] = params[:wristband]
      redirect_to :zebra_home_index
    else
      redirect_to :zebra_index
    end
  end

  def destroy
    cookies.delete :zebra_token
    redirect_to :zebra_index
  end

  private
  
  def logged_in?
    unless check_token(cookies[:zebra_token])
      redirect_to :zebra_sessions
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
