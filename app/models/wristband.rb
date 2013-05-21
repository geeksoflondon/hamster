#Wrapper for handling common wristband events
class Wristband

  #Bind a wristband to a ticket
  def self.create(ticket, wristband_id)
    raise 'Wristband can only be attached to a ticket.' unless ticket.is_a? Ticket
    raise 'Wristband exists already' unless self.exists(wristband_id) === false
    ticket.interaction.create(:key => 'wristband', :value => wristband_id)
  end

  #Swap a wristband
  def self.swap(from_id, to_id)
  end

  #Find a wristband and return the corresponding ticket
  def self.find(wristband_id)
  end
  
  private
  
  #Checks wristband is unique
  def self.exists?(wristband_id)
  end

end