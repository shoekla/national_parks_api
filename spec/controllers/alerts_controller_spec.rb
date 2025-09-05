require 'rails_helper'

RSpec.describe 'API::V1::Alerts', type: :request do
  let!(:park1) { Park.create!(code: 'yose', name: 'Yosemite', states: [ 'CA' ]) }

  let!(:alert1)   { Alert.create!(park: park1, title: 'Fire', category: 'Warning') }
  let!(:alert2)   { Alert.create!(park: park1, title: 'Park Closure', category: 'Info') }

  describe 'GET /api/v1/parks/:park_code/alerts' do
    it 'returns all alerts for a given park' do
      get "/api/v1/parks/#{park1.code}/alerts"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json.length).to eq(2)
      titles = json.map { |a| a['title'] }
      expect(titles).to include('Fire', 'Park Closure')
    end

    it 'returns 204 for nonexistent park' do
      get '/api/v1/parks/invalid/alerts'

      expect(response).to have_http_status(:not_found)
      json = JSON.parse(response.body)
      expect(json['error']).to be_present
    end
  end
end
