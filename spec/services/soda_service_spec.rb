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

    context 'given two months to compare' do
      it "returns two field sets" do
        VCR.use_cassette 'name_year_two_months' do
          expected = [
            {
              "alderman_name": "Edward M. Burke",
              "ward": "14",
              "report_month_beginning": "2018-04-01T00:00:00",
              "number_of_requests": 428
            },
            {
              "alderman_name": "Edward M. Burke",
              "ward": "14",
              "report_month_beginning": "2018-05-01T00:00:00",
              "number_of_requests": 406
            }
          ]

          expect(
            service.get(
              last_name: "Burke",
              month: "4,5",
              year: "2018",
            )).to eq(expected)
        end
      end
    end

    context 'given two last names(wards) to compare' do
      it "returns two field sets" do
        VCR.use_cassette 'two_names_year_month' do
          expected = [
            {
              "alderman_name": "Michelle A. Harris",
              "ward": "8",
              "report_month_beginning": "2018-05-01T00:00:00",
              "number_of_requests": 3
            },
            {
              "alderman_name": "Edward M. Burke",
              "ward": "14",
              "report_month_beginning": "2018-05-01T00:00:00",
              "number_of_requests": 406
            }
          ]

          expect(
            service.get(
              last_name: "Burke,Harris",
              month: "5",
              year: "2018",
            )).to eq(expected)
        end
      end
    end
  end
end
