#Wrapper for handling common wristband events
class Wristband

  #Bind a wristband to a ticket
  def create(wristband_id, ticket_id)
  end

  #Swap a wristband
  def swap(from_id, to_id)
  end

  #Find a wristband and return the corresponding ticket
  def find(wristband_id)
  end
  
  private
  
  #Checks wristband is unique
  def exists?(wristband_id)
  end

end