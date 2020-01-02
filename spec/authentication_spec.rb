require 'rails_helper'

RSpec.describe 'POST /login', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:url) { admin_user_token_url }
  let(:params) do
    {
      auth: {
        email: user.email,
        password: user.password
      }
    }
  end


  context 'when params are correct' do
    before do
      post url, params: params
    end

    it 'returns 201' do
      expect(response).to have_http_status(201)
    end

    it 'returns JTW token in authorization header' do
      expect(JSON.parse(response.body)['jwt']).to be_present
    end

    it 'returns valid JWT token' do
      # decoded_token = decoded_jwt_token_from_response(response)
      # expect(decoded_token.first['sub']).to be_present
      token = JSON.parse(response.body)['jwt']
      # puts token
      decoded_token = JWT.decode(token, nil, false)
      # puts decoded_token
      expect(decoded_token.first['sub']).to be_present
    end
  end

  context 'when login params are incorrect' do
    before { post url, params: { auth: { email: user.email, password: "wrongpassword" } }}
    
    it 'returns unathorized status' do
      expect(response.status).to eq 404
    end
  end
end