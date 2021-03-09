require 'oystercard'

describe Oystercard do
  let(:test_card) { Oystercard.new(20) }
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

  describe 'touch_in' do
    # can we call touch_in without specifying a station
    # default value no appropriate in method - buggy.

    it 'will return an error if the card has less than £1 balance' do
      expect { subject.touch_in("Euston") }.to raise_error("Not enough money to touch in")
    end

    it 'changes the start_location to the current station provided' do
      expect { test_card.touch_in("Euston") }
      .to change { test_card.start_location }.to("Euston")
    end
  end

  describe 'touch_out' do
    before do
      test_card.instance_variable_set(:@journey, true)
      test_card.instance_variable_set(:@start_location, "Euston")
    end

    it "touching out deducts the minimum fare" do
      expect { test_card.touch_out }.to change { test_card.balance }.by -Oystercard::DEFAULT_MINIMUM
    end

    it "will return an error if the deducted amount exceeds the total remaining" do
      expect { subject.touch_out }.to raise_error("The deducted amount exceeds the total remaining balance") 
    end

    it 'changes the start_location to nil on touch out' do
      expect { test_card.touch_out }
      .to change { test_card.start_location }.to(nil)
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

# In order to pay for my journey
# As a customer
# When my journey is complete, I need the correct amount deducted from my card

# In order to pay for my journey
# As a customer
# I need to know where I've travelled from