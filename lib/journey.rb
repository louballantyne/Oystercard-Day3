class Journey
  attr_reader :start_location, :history

  def initialize(oystercard)
    @history = []
    @card = oystercard
  end

  def journey_start(station)
    store_journey if @start_location!=nil
    @end_location = nil
    @start_location = station
  end

  def journey_end(station)
    @end_location = station
    store_journey
    @start_location = nil
  end

  def in_journey?
    @start_location != nil
  end

  def store_journey
    @history << { :start => @start_location, :end => @end_location }
    (@start_location == nil || @end_location == nil) ? @card.calc_fare(true) : @card.calc_fare(false)
  end

end
