require 'journey'

describe Journey do
  let(:test_journey) { Journey.new(Oystercard.new(10)) }
=begin
  describe 'journey_start' do
    it 'calling ' do
      expect{ test_journey.journey_start("Euston") }
      .to change { test_journey.start_location }.to("Euston")
    end
  end


    describe 'get journeys' do
      before do
        test_journey.instance_variable_set(:@start_location, "Euston")
      end
      it 'returns a list of previous journeys' do
        expect{ test_journey.journey_end("Hampstead") }
        .to change { test_journey.history }.to([{ :start => "Euston", :end => "Hampstead" }])
      end
    end
  end
=end
end
