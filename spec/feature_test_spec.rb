require 'oystercard'

describe 'Oystercard features' do
  it 'touching in and out creates one journey' do
    card = Oystercard.new(Oystercard::DEFAULT_MINIMUM)
    card.touch_in("Euston")
    card.touch_out("Hampstead")
    expect(card.history.first).to eq({ :start => "Euston", :end => "Hampstead" }) 
  end
end