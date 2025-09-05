require 'rails_helper'

RSpec.describe 'API::V1::Parks', type: :request do
  let!(:park1) { Park.create!(code: 'yose', name: 'Yosemite', states: [ 'CA' ]) }
  let!(:park2) { Park.create!(code: 'grca', name: 'Grand Canyon', states: [ 'AZ' ]) }
  let!(:park3) { Park.create!(code: 'zion', name: 'Zion', states: [ 'UT', 'AZ' ]) }

  describe 'GET /api/v1/parks' do
    it 'returns all parks' do
      get '/api/v1/parks'
      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json['parks'].size).to eq(3)
    end

    it 'filters parks by state' do
      get '/api/v1/parks', params: { state: 'AZ' }
      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json['parks'].map { |p| p['code'] }).to contain_exactly('grca', 'zion')
    end

    it 'supports pagination' do
      get '/api/v1/parks', params: { page: 1, per_page: 2 }
      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json['parks'].size).to eq(2)
      expect(json['current_page']).to eq(1)
      expect(json['total_pages']).to eq(2)
      expect(json['total_count']).to eq(3)
    end
  end

  describe 'GET /api/v1/parks/:code' do
    it 'returns the correct park' do
      get '/api/v1/parks/yose'
      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json['code']).to eq('yose')
      expect(json['name']).to eq('Yosemite')
    end

    it 'returns 404 if park does not exist' do
      get '/api/v1/parks/invalid'
      expect(response).to have_http_status(:not_found)

      json = JSON.parse(response.body)
      expect(json['error']).to be_present
    end
  end
end
