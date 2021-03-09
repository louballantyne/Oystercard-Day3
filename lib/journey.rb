class Journey
  attr_reader :start_location, :history

  def initialize
    @history = []
  end

  def journey_start(station)
    @start_location = station
  end

  def journey_end(station)
    store_journey(station)
    @start_location = nil
  end


  def in_journey?
    @start_location != nil
  end

  def store_journey(station)
    history << { :start => @start_location, :end => station }
  end

end
  
  
  
  