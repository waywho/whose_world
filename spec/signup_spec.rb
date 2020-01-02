require 'rails_helper'

RSpec.describe 'POST /sign_up', type: :request do
  let(:url) { '/admin/sign_up' }
  let(:params) do
    {
      user: {
        email: 'user@example.com',
        password: 'password'
      }
    }
  end

  context 'when user is new' do
    before do
      post url, params: params
    end

    it 'returns 201' do
      expect(response.status).to eq 201
    end

    it 'returns a new user' do
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['body']['payload']["email"]).to eq("user@example.com")
    end

    it 'returns JTW token in authorization header' do
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['body']['token']).to be_present
    end
  end

  context 'when user already exists' do
    before do
      FactoryBot.create(:user, email: params[:user][:email])
      post url, params: params
    end

    it 'returns bad request status' do
      expect(response.status).to eq 400
    end

    it 'returns validation errors' do
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['errors'].first['title']).to eq('Bad Request')
    end
  end
end