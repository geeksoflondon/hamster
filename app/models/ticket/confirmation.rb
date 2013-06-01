class Ticket
  class Confirmation < SimpleDelegator

    def save params
      return false if validate(params)

      interactions.create(key: "confirmed", value: true)
      if params[:attending] === 'yes'
        interactions.create(key: "attending", value: true)
      else
        interactions.create(key: "attending", value: false)
      end
      true
    end

    def token
      woodpecker_token
    end

    def attending?
      interactions.where(key: "attending", current: true).last.try(:value) ===  "true"
    end

    private

    def validate params
      params.keys.include? :attending
    end
  end
end