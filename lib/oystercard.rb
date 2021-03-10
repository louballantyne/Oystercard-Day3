#require 'station'
#require 'journey'

class Oystercard

  DEFAULT_MAXIMUM = 90
  DEFAULT_MINIMUM = 1
  PENALTY_FARE = 6
  attr_reader :balance, :default_maximum

  def initialize(balance = 0, journey = Journey.new(self))
    @balance = balance
    @journey = journey
  end

  def top_up(money)
      fail "Top-up exceeds the predetermined maximum" if @balance + money >  DEFAULT_MAXIMUM
    @balance += money
  end

  def touch_in(station)
    fail "Not enough money to touch in" if @balance < DEFAULT_MINIMUM
    @journey.journey_start(station)
  end

  def touch_out(station)
    @journey.journey_end(station)
  end

  def get_journeys
    @journey.history
  end

  def calc_fare(penalty)
    penalty == true ? deduct(PENALTY_FARE) : deduct(DEFAULT_MINIMUM)
  end

  private

  def deduct(fare)
    fail "The deducted amount exceeds the total remaining balance" if @balance - fare < 0
    @balance -= fare
  end
end
