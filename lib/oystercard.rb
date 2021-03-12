#require 'station'
#require 'journey'
#ßrequire 'journeylog'

class Oystercard

  DEFAULT_MAXIMUM = 90
  DEFAULT_MINIMUM = 1
  PENALTY_FARE = 6
  attr_reader :balance, :default_maximum

  def initialize(balance = 0, journeylog = JourneyLog.new(self))
    @balance = balance
    @journeylog = journeylog
  end

  def top_up(money)
    fail "Top-up exceeds the predetermined maximum" if @balance + money >  DEFAULT_MAXIMUM
    @balance += money
  end

  def touch_in(station)
    fail "Not enough money to touch in" if @balance < DEFAULT_MINIMUM
    @journeylog.start_journey(station)
  end

  def touch_out(station)
    @journeylog.end_journey(station)
  end

  def get_journeys
    @journeylog.history.clone
  end

  def calc_fare(penalty)
    if penalty == true
      deduct(PENALTY_FARE)
      puts "Penalty fare deducted"
    else
      deduct(DEFAULT_MINIMUM)
      puts "Fare deducted"
    end
  end

  def current_journey
    @journeylog.current_journey
  end

  private

  def deduct(fare)
    fail "The deducted amount exceeds the total remaining balance" if @balance - fare < 0
    @balance -= fare
  end
end
