class Oystercard
  
  DEFAULT_MAXIMUM = 90
  DEFAULT_MINIMUM = 1

  attr_reader :balance, :default_maximum, :journey

  def initialize(balance = 0, default_maximum = DEFAULT_MAXIMUM)
    @balance = balance
    @default_maximum = default_maximum
    @journey = false
  end

  def top_up(money)
    fail "Top-up exceeds the predetermined maximum" if @balance + money > @default_maximum
    @balance += money
  end

  def touch_in
    fail "Not enough money to touch in" if @balance < DEFAULT_MINIMUM
    @journey = true
  end

  def touch_out
    deduct(DEFAULT_MINIMUM)
    @journey = false
  end

  private 
  
  def in_journey?
    @journey
  end

  def deduct(money)
    fail "The deducted amount exceeds the total remaining balance" if @balance - money < 0
    @balance -= money
  end
end
