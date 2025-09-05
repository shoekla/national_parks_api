require 'rails_helper'

RSpec.describe 'API::V1::Stats', type: :request do
  let!(:park1) { Park.create!(code: 'yose', name: 'Yosemite', states: [ 'CA' ]) }
  let!(:park2) { Park.create!(code: 'grca', name: 'Grand Canyon', states: [ 'AZ' ]) }
  let!(:park3) { Park.create!(code: 'zion', name: 'Zion', states: [ 'UT', 'AZ' ]) }

  let!(:alert1)   { Alert.create!(park: park1, title: 'Fire', category: 'Warning') }
  let!(:alert2)   { Alert.create!(park: park1, title: 'Park Closure', category: 'Info') }
  let!(:alert3)   { Alert.create!(park: park1, title: 'Flood', category: 'Info') }
  let!(:alert4)   { Alert.create!(park: park2, title: 'Fire', category: 'Info') }
  let!(:alert5)   { Alert.create!(park: park2, title: 'Park Closure', category: 'Info') }
  let!(:alert6)   { Alert.create!(park: park3, title: 'Park Closure', category: 'Info') }

  describe 'GET /api/v1/stats' do
    it 'returns aggregated stats' do
      get '/api/v1/stats'
      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      # Check top-level counts
      expect(json['total_parks']).to eq(3)
      expect(json['total_alerts']).to eq(6)

      expect(json['parks_by_state']).to eq({ 'AZ'=>2, 'CA'=>1, 'UT'=>1 })

      # Check top parks with alerts
      top_parks_by_alerts = json['top_parks_by_alerts']
      expect(top_parks_by_alerts.length).to eq(3)
      expect(top_parks_by_alerts).to eq([
        { 'park_code' => 'yose', 'park_name' => 'Yosemite', 'alerts_count' => 3 },
        { 'park_code' => 'grca', 'park_name' => 'Grand Canyon', 'alerts_count' => 2 },
        { 'park_code' => 'zion', 'park_name' => 'Zion', 'alerts_count' => 1 }
      ])
    end
  end
end
