# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe '#Auth' do
    let(:user) { create(:user) }
    let(:user_name) { user.user_name }
    let(:password) { user.password }
    let(:token) { JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base) }

    context 'when valid user name and password credentials' do
      before { allow(User).to receive(:find_by).with(user_name:).and_return(user) }

      it 'returns a json response containing a token' do
        post '/auth', params: { user_name:, password: }

        expect(response).to have_http_status(:success)              
        expect(JSON.parse(response.body).dig('token')).to eq(token)
      end
    end

    context 'when invalid user name or password credentials are provided' do
      it 'returns an unprocessable entity error' do
        post '/auth', params: { user_name:, password: 'blah' }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq('errors' => 'Invalid user/password')
      end
    end
  end
end
