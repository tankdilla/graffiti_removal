require 'rails_helper'

describe SodaService do
  describe '#get' do
    let(:service) { SodaService.new }
    context 'given last name, year, and month' do
      it 'returns expected fields' do
        VCR.use_cassette 'name_year_month' do
          expected = [
            {
              "alderman_name": "Edward M. Burke",
              "ward": "14",
              "report_month_beginning": "2018-05-01T00:00:00",
              "number_of_requests": 406
            }
          ]

          expect(service.get(last_name: "Burke", month: "5", year: "2018")).to eq(expected)
        end
      end
    end

    context 'given last name, year, month, and graffiti_location' do
      it 'returns expected fields' do
        VCR.use_cassette 'name_year_month_location' do
          expected = [
            {
              "alderman_name": "Edward M. Burke",
              "ward": "14",
              "report_month_beginning": "2018-05-01T00:00:00",
              "number_of_requests": 103
            }
          ]

          expect(
            service.get(
              last_name: "Burke",
              month: "5",
              year: "2018",
              graffiti_location: "Side"
          )).to eq(expected)
        end
      end
    end

    context 'given last name, year, month, graffiti location, and graffiti surface' do
      it 'returns expected fields' do
        VCR.use_cassette 'name_year_month_location_surface' do
          expected = [
            {
              "alderman_name": "Edward M. Burke",
              "ward": "14",
              "report_month_beginning": "2018-05-01T00:00:00",
              "number_of_requests": 37
            }
          ]

          expect(
            service.get(
              last_name: "Burke",
              month: "5",
              year: "2018",
              graffiti_location: "Side",
              graffiti_surface: "Brick - Unpainted"
          )).to eq(expected)
        end
      end
    end
  end
end
