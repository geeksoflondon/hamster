class OnsiteregController < ApplicationController
  
  before_filter :logged_in?, :except => [:index]
  
  def index
  end
  
  def show
  end

  private
  
  def logged_in?
    unless valid_login(cookies[:onsitereg_token])
      redirect_to :onsitereg_index
    end
  end
  
  def login
    #check wristband is authorised to do on-site reg
      #set cookie if user is allowed
  end

  def valid_login(token = '')
    #ticket = Interaction.where(:interactable_type => 'Ticket', :key => 'wristband', :value => params[:wristband])
  end

end