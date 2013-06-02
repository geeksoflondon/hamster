class Ticket
  class Confirmation < SimpleDelegator
    include Interactable

    def save params
      return false unless valid params

      is_confirmed!
      has "attending", params[:attending] === 'yes'
      true
    end

    def token
      get Ticket::RETAIN_TOKEN
    end

    private

    def valid params
      params.keys.include? "attending"
    end
  end
end