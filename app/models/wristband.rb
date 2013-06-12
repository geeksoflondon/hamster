#Wrapper for handling common wristband events
class Wristband
  include Interactable

  #Bind a wristband to a ticket
  def self.create ticket, wristband_id
    raise 'Wristband can only be attached to a ticket.' unless ticket.is_a? Ticket
    raise 'Wristband exists already' if self.exists?(wristband_id)

    ticket.has "wristband", wristband_id
  end

  #Find a wristband and return the corresponding ticket
  def self.find wristband_id
    Ticket.get "wristband", wristband_id
  end

  private

  #Checks wristband is unique
  def self.exists? wristband_id
    !find(wristband_id).nil?
  end

end