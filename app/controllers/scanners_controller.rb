class ScannersController < ApplicationController
  # 
  # before_filter :token_name, only: [:edit]
  # before_filter :limit, only: [:update]
  # 
  # def show
  # end
  # 
  # def edit
  #   
  # end
  # 
  # def update
  #   wristband = get_wristband(params[:wristband])
  #   not_found unless wristband
  #   
  #   token = wristband.get params[:token]
  #   
  #   if token.nil?
  #     uses = 0
  #   end
  #   
  #   if uses >= @limit
  #     use_exceeded
  #   else
  #     value = uses + 1
  #     wristband.has "#{params[:token]}" value
  #     flash[:notice] = "#{wristband.attendee.name} claimed their #{@token_name}"
  #     redirect_to "/scanner/edit/#{params[:token_name]}"
  #   end
  # end
  # 
  # private
  # 
  # def token_name    
  #   
  # case params[:token]
  #   when 'coffee'
  #     @token_name = "Coffee"
  #   when 'sat_lunch'
  #     @token_name = "Saturday Lunch"
  #   when 'sat_dinner'
  #     @token_name = "Saturday Dinner"
  #   when 'sat_beer'
  #     @token_name = "Saturday Beer"
  #   when 'sun_breakfast'
  #     @token_name = "Sunday Breakfast"
  #   when 'sun_lunch'
  #     @token_name = "Sunday Lunch"
  #   else
  #     raise "Thats not a valid token"
  #   end
  # end
  # 
  # def limit
  #   case params[:token]
  #     when 'sat_beer'
  #       @limit = 2
  #     else
  #       @limit = 1
  #     end
  # end
  # 
  # def get_wristband(wristband_id = nil)
  #    return false if wristband_id.nil?
  #    wristband = Wristband.find(wristband_id)
  #    return false unless wristband.present?
  #    wristband
  #  end
  #  
  #  def not_found
  #    flash[:notice] = "Wristband not found"
  #    redirect_to "/scanner/edit/#{params[:token]}"
  #  end
  #  
  #  def use_exceeded
  #    flash[:notice] = "Uses exceeded"
  #    redirect_to "/scanner/edit/#{params[:token]}"
  #  end
  # 
end