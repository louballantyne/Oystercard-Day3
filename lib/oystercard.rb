#require 'station'
#require 'journey'

class Oystercard
  
  DEFAULT_MAXIMUM = 90
  DEFAULT_MINIMUM = 1

  attr_reader :balance, :default_maximum

  def initialize(balance = 0, journey = Journey.new)
    @balance = balance
    @default_maximum = default_maximum
    @journey = journey
  end

  def top_up(money)
    fail "Top-up exceeds the predetermined maximum" if @balance + money > @default_maximum
    @balance += money
  end

  def touch_in(station)
    fail "Not enough money to touch in" if @balance < DEFAULT_MINIMUM
    @journey.journey_start(station)
  end

  def touch_out(station)
    deduct(DEFAULT_MINIMUM)
    @journey.journey_end(station)
  end

  private

  def deduct(money)
    fail "The deducted amount exceeds the total remaining balance" if @balance - money < 0
    @balance -= money
  end
end
