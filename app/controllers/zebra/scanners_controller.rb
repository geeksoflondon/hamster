class Zebra::ScannersController < Zebra::SessionsController
  
  before_filter :logged_in?, :user, :event, :tokens
  
  def show
    @selected = cookies[:scanner_token] 
  end
  
  def create
    token = params[:token]
    @ticket = get_wristband(params[:wristband])
    
    if @ticket.present?
      use_token(token)
    else
      flash[:error] = "Wristband not found"
    end
    
    cookies[:scanner_token] = token
    
    redirect_to '/zebra/scanner'
  end
  
  private
  
  def tokens
    @tokens = {
      gift_bag: 'Gift Bag',
      sat_lunch: 'Saturday Lunch',
      sat_dinner: 'Saturday Dinner',
      beer: 'Beer',
      sun_breakfast: 'Sunday Breakfast',
      sun_lunch: 'Sunday Lunch'
    }
  end
  
  def use_token(token)
    if @ticket.get token
      flash[:error] = "Wristband already has used this token"
    else
      @ticket.has token, true
      flash[:notice] = "#{@ticket.attendee.first_name} #{@ticket.attendee.last_name} claimed #{token}"
    end
  end
end