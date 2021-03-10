require 'journey'

describe Journey do
  let(:test_journey) { Journey.new(Oystercard.new(10)) }

  it "has an empty list of journeys by default" do
    expect(test_journey.history).to eq []
  end

  describe 'journey_start' do
    it 'changes the start_location to the current station provided' do
      expect{ test_journey.journey_start("Euston") }
      .to change { test_journey.start_location }.to("Euston")
    end
  end

  describe 'journey_end' do
    before do
      test_journey.instance_variable_set(:@start_location, "Euston")
    end
    it 'changes the start_location to nil' do
      expect { test_journey.journey_end("Hampstead") }
      .to change { test_journey.start_location }.to(nil)
    end
  end
end
