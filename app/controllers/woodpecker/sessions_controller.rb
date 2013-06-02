#OnSite Registration Tool
class Woodpecker::SessionsController < ApplicationController

  before_filter :ensure_logged_in, :except => [:index, :create]

  layout 'woodpecker'

  COOKIE_KEY = :woodpecker_token

  def index
    redirect_to :woodpecker_confirmation if logged_in?
  end

  def create
    if valid_token?
      login
      redirect_to :woodpecker_confirmation
    else
      redirect_to :woodpecker_sessions
    end
  end

  def destroy
    logout
    redirect_to :woodpecker_sessions
  end

  private

  def ensure_logged_in
    unless logged_in?
      redirect_to :woodpecker_sessions
    end
  end

  def logged_in?
    verify_token(cookies[COOKIE_KEY])
  end

  def valid_token?
    verify_token(params[COOKIE_KEY])
  end

  def verify_token(token = nil)
    return false if token.nil?
    Ticket.get("woodpecker_token", token).present?
  end

  def login
    cookies[COOKIE_KEY] = params[COOKIE_KEY]
  end

  def logout
    cookies.delete COOKIE_KEY
  end

end
