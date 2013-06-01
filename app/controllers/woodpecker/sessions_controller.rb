#OnSite Registration Tool
class Woodpecker::SessionsController < ApplicationController

  before_filter :logged_in?, :except => [:index, :create]

  layout 'woodpecker'

  def index
    redirect_to :woodpecker_confirm if check_cookie(cookies[:woodpecker_token])
  end

  def create
    if check_cookie(params[:woodpecker_password]) === true
      cookies[:woodpecker_token] = params[:woodpecker_password]
      redirect_to :woodpecker_confirm
    else
      redirect_to :woodpecker_root
    end
  end

  def destroy
    cookies.delete :woodpecker_token
    redirect_to :woodpecker_root
  end

  private
  
  def logged_in?
    unless check_cookie(cookies[:woodpecker_token])
      redirect_to :woodpecker_root
    end
  end

  def check_token(token)
    woodpecker_token = Interaction.where(:key => 'woodpecker_password', :value => token, :current => true)
    woodpecker_token.empty? ? nil : woodpecker_token.first.interactable
  end

  def check_cookie(token = nil)
    return false if token.nil?
    woodpecker_token = check_token(token)
    return false unless woodpecker_token.present?
    true
  end

end
