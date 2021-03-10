require 'oystercard'
require 'journey'

describe Oystercard do
  let(:test_card) { Oystercard.new(10) }

  it "has a balance of zero" do
    expect(subject.balance).to eq(0)
  end

  describe 'top_up' do
    it "will add money to the balance of the card" do
      expect { subject.top_up 1 }.to change { subject.balance }.by 1
    end
    it "will return an error if the total would exceed the default maximum" do
      expect { subject.top_up(1 + Oystercard::DEFAULT_MAXIMUM) }.to raise_error("Top-up exceeds the predetermined maximum")
    end
  end

  describe 'touch_in' do
    # can we call touch_in without specifying a station
    # default value no appropriate in method - buggy.

    it 'will return an error if the card has less than £1 balance' do
      expect { subject.touch_in("Euston") }.to raise_error("Not enough money to touch in")
    end
  end

  describe 'touch_out' do
    before do
      test_card.instance_variable_set(:@journey, true)
      test_card.instance_variable_set(:@start_location, "Euston")
    end

    it "will return an error if the deducted amount exceeds the total remaining" do
      expect { subject.touch_out("Hampstead") }
      .to raise_error("The deducted amount exceeds the total remaining balance")
    end

    it "touching out deducts the minimum fare" do
      test_card = Oystercard.new(20)
      test_card.touch_in("Angel")
      expect { test_card.touch_out("Euston") }
      .to change { test_card.balance }.by -Oystercard::DEFAULT_MINIMUM
    end

    it "touching out deducts a penalty fare if there has been no touch in" do
      test_card = Oystercard.new(20)
      expect { test_card.touch_out("Euston") }
      .to change { test_card.balance }.by -6
    end

    it "touching in deducts a penalty fare if there has been no touch out" do
      test_card = Oystercard.new(20)
      test_card.touch_in("Angel")
      expect { test_card.touch_in("Euston") }
      .to change { test_card.balance }.by -6
    end
  end
end
