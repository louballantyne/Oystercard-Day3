
class JourneyLog

  attr_accessor :history, :in_journey
  def initialize( oystercard, journey = Journey)
    @history = []
    @journey = journey
    @card = oystercard
    @in_journey = false
  end
 #start
  def start_journey(station)
    no_touch_out
    @journey_instance = @journey.new
    @journey_instance.set_start_station(station)
    @in_journey = true
  end
#finish
  def end_journey(station)
    no_touch_in
    @journey_instance.set_end_station(station)
    store_journey
    @in_journey = false
  end

  def no_touch_out
    if @in_journey == true
      store_journey
      puts "Incomplete journey stored"
    end
  end

  def no_touch_in
    if @in_journey == false
        @journey_instance = @journey.new
        puts "Failure to touch in detected"
    end
  end

  def store_journey
    charge(@journey_instance.start_station, @journey_instance.end_station)
    @history << @journey_instance
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
