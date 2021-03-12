require 'journeylog'
require 'journey'
require 'oystercard'

describe JourneyLog do
  card = Oystercard.new(10)
  let(:test_journey_log) { JourneyLog.new(card) }

  it "has an empty list of journeys by default" do
    expect(test_journey_log.history).to eq []
  end

  context 'it creates a new journey' do
    it 'records the start location when start_journey is called in a new instance of Journey' do
      journey_double = double :journey_double
      journey_class_double = double :journey_class_double, new: journey_double
      card = Oystercard.new(10,journeylog = JourneyLog.new(self,journey_class_double))
      expect(journey_class_double).to receive(:new)
      expect(journey_double).to receive(:set_start_station).with("Euston")
      card.touch_in("Euston")
    end
  end

  context 'it ends a journey' do
    it 'records the end location when end_journey is called' do
      journey_double = double :journey_double
      journey_class_double = double :journey_class_double, new: journey_double
      card = double :card_double
      test_journey_log2 = JourneyLog.new(card, journey_class_double)
      allow(card).to receive(:touch_out).with("Euston") {test_journey_log2.end_journey("Euston")}
      allow(journey_class_double).to receive(:new) {journey_double}
      allow(journey_double).to receive(:start_station)
      allow(journey_double).to receive(:set_start_station)
      allow(journey_double).to receive(:set_end_station).with("Euston")
      allow(journey_double).to receive(:end_station)
      journey_double.instance_variable_set(:@start_station, "Archway")
      allow(card).to receive(:calc_fare).with(true)
      card.touch_out("Euston")
      expect(test_journey_log2.history).to include(journey_double)
    end
  end

  context 'it returns a list of journeys' do
    before do
      journey_double = double :journey_double
      journey_class_double = double :journey_class_double, new: journey_double
      card = double :card_double
      test_journey_log2 = JourneyLog.new(card, journey_class_double)
      allow(card).to receive(:touch_out).with("Euston") {test_journey_log2.end_journey("Euston")}
      allow(journey_class_double).to receive(:new) {journey_double}
      allow(journey_double).to receive(:start_station)
      allow(journey_double).to receive(:set_end_station).with("Euston")
      allow(journey_double).to receive(:end_station)
      journey_double.instance_variable_set(:@start_station, "not nil")
      allow(card).to receive(:calc_fare).with(true)
      card.touch_out("Euston")

    end
  end
end
