require 'oystercard'

describe Oystercard do
  it "has a balance of zero" do
    expect(subject.balance).to eq(0)
  end

  describe 'top_up' do
    it "will add money to the balance of the card" do
      expect { subject.top_up 1 }.to change { subject.balance }.by 1
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
