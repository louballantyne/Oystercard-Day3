require 'oystercard'

describe Oystercard do
  test_card = Oystercard.new(20)
  it "has a balance of zero" do
    expect(subject.balance).to eq(0)
  end

  describe 'top_up' do
    it "will add money to the balance of the card" do
      expect { subject.top_up 1 }.to change { subject.balance }.by 1
    end
    it "will return an error if the total would exceed the default maximum" do
      expect { subject.top_up(1 + subject.default_maximum) }.to raise_error("Top-up exceeds the predetermined maximum")
    end
  end

  describe 'deduct' do
    it 'deducts a fare from the balance of the card' do
      expect { test_card.deduct(15) }.to change { test_card.balance }.by -15
    end
    it "will return an error if the deducted amount exceeds the total remaining" do
      expect { test_card.deduct(10) }.to raise_error("The deducted amount exceeds the total remaining balance") 
    end
  end

  describe 'touch_in' do
    it 'touches in a card and sets journey to true' do
      expect { test_card.touch_in }.to change { test_card.journey }.to be true
    end

    it 'will return an error if the card has less than £1 balance' do
      expect { subject.touch_in }.to raise_error("Not enough money to touch in")
    end
  end

  describe 'touch_out' do
    it "touches out a card and sets the journey to false" do
      # How can we isolate this unit test?
      test_card.touch_in
      expect { test_card.touch_out }.to change { test_card.journey }.to be false
    end
  end
end

# In order to use public transport
# As a customer
# I want money on my card

# In order to keep using public transport
# As a customer
# I want to add money to my card

# In order to protect my money from theft or loss
# As a customer
# I want a maximum limit (of £90) on my card

# In order to pay for my journey
# As a customer
# I need my fare deducted from my card

# In order to get through the barriers.
# As a customer
# I need to touch in and out.

# In order to pay for my journey
# As a customer
# I need to have the minimum amount (£1) for a single journey.