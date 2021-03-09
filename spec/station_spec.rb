require 'station' 

describe Station do
  let(:test_station) { Station.new("Acton Town", 3) }

  it 'knows what zone a station is' do
      expect(test_station.zone).to eq 3
  end

  it 'knows what name a station is' do
    expect(test_station.name).to eq "Acton Town"
  end

end