class Ticket
  class Confirmation < SimpleDelegator
    include Interactable

    def save params
      return false unless valid params
      @params = params

      attendee.first_name = params[:first_name]
      attendee.last_name = params[:last_name]
      attendee.twitter = params[:twitter]
      
      is_confirmed!
      has "attending", params[:attending] == 'true'
      check :saturday
      check :sunday
      check :overnight
      
      attendee.save
    end

    def token
      get Ticket::RETAIN_TOKEN
    end

    private

    def valid params
      params.keys.include? "attending"
    end
    
    def check key
      has "attending_#{key}", @params[key] == 'true'
    end
  end
end