#Wrapper for handling common wristband events
class Wristband

  #Bind a wristband to a ticket
  def self.create(ticket, wristband_id)
    raise 'Wristband can only be attached to a ticket.' unless ticket.is_a? Ticket
    raise 'Wristband exists already' if self.exists?(wristband_id)
    ticket.interactions.create(:key => 'wristband', :value => wristband_id)
  end

  #Find a wristband and return the corresponding ticket
  def self.find(wristband_id)
    wristband = Interaction.where(:key => 'wristband', :value => wristband_id, :current => true)
    wristband.empty? ? nil : wristband.first.interactable
  end
  
  private
  
  #Checks wristband is unique
  def self.exists?(wristband_id)
    wristband = Interaction.where(:key => 'wristband', :value => wristband_id).count
    wristband >= 1
  end

end