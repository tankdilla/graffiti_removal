require 'rails_helper'

describe GraffitiRemovalsController do
  describe "GET #index" do
    context "required params" do
      let(:params) { { last_name: "Burke", year: 2018, month: 5 } }

      it "returns 200 status" do
        VCR.use_cassette 'name_year_month' do
          get :index, params: params
          expect(response.status).to eq(200)
        end
      end

      it "returns the expected body" do
        VCR.use_cassette 'name_year_month' do
          expected = [
            {
              "alderman_name": "Edward M. Burke",
              "ward": "14",
              "report_month_beginning": "2018-05-01T00:00:00",
              "number_of_requests": 406
            }.stringify_keys
          ]

          get :index, params: params
          expect(JSON.parse(response.body)).to eq(expected)
        end
      end
    end

    context "missing params" do
      shared_examples "missing params" do
        it "returns 422" do
          get :index, params: params
          expect(response.status).to eq(422)
        end

        it "returns an error message" do
          expected = {
            message: "last_name, month, and year are required params"
          }.stringify_keys

          get :index, params: params
          expect(JSON.parse(response.body)).to eq(expected)
        end
      end

      context "missing month" do
        let(:params) { { last_name: "Burke", year: 2018 } }

        it_behaves_like "missing params"
      end

      context "missing year" do
        let(:params) { { last_name: "Burke", month: 5 } }

        it_behaves_like "missing params"
      end

      context "missing last name" do
        let(:params) { { year: 2018, month: 5 } }

        it_behaves_like "missing params"
      end
    end
  end
end
