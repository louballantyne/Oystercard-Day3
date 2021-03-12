
class JourneyLog

  attr_accessor :start_location, :end_location, :history, :in_journey
  def initialize( oystercard, journey = Journey)
    @history = []
    @journey = journey
    @card = oystercard
    @in_journey = false
  end
 #start
  def start_journey(station)
    if @in_journey == true
      @end_location = nil
      store_journey
      puts "Incomplete journey stored"
    end
    @journey_instance = @journey.new
    @start_location = station
    @journey_instance.set_start_station(station)
    @in_journey = true
  end
#finish
  def end_journey(station)
    if @in_journey == false
        @journey_instance = @journey.new
        puts "Failure to touch in detected"
        @start_location = nil
    else
      @journey_instance.set_start_station(@start_location)
    end
    @journey_instance.set_end_station(station)
    @end_location = station
    store_journey
    @in_journey = false
  end

  def store_journey
    charge(@start_location, @end_location)
    @history << @journey_instance
  end

  def journeys
    @history
  end


  def charge(start_location, end_location)
    (start_location == nil || end_location == nil) ? @card.calc_fare(true) : @card.calc_fare(false)
  end

  private


  def current_journey
    if in_journey?
      "In Journey, started from: #{@journey_instance.start_station}"
    else
      start_journey(station = nil)
    end
  end
end
