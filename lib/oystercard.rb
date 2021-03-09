class Oystercard
  
  DEFAULT_MAXIMUM = 90
  DEFAULT_MINIMUM = 1

  attr_reader :balance, :default_maximum, :start_location, :history

  def initialize(balance = 0, default_maximum = DEFAULT_MAXIMUM)
    @balance = balance
    @default_maximum = default_maximum
    @history = []
  end

  def top_up(money)
    fail "Top-up exceeds the predetermined maximum" if @balance + money > @default_maximum
    @balance += money
  end

  def touch_in(station)
    fail "Not enough money to touch in" if @balance < DEFAULT_MINIMUM
    @start_location = station
  end

  def touch_out(station)
    deduct(DEFAULT_MINIMUM)
    store_journey(station)
    @start_location = nil
  end

  private 
  
  def in_journey?
    @start_location != nil
  end

  def deduct(money)
    fail "The deducted amount exceeds the total remaining balance" if @balance - money < 0
    @balance -= money
  end

  def store_journey(station)
    history << { :start => @start_location, :end => station }
  end
end
