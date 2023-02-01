# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employees', type: :request do    
  let!(:department) { create(:department) }
  let(:employee) { create(:employee) }
  let(:employees) { create_list(:employee, 3) }

  let(:user) { create(:user) }
  let(:jwt_token) { JWT.encode({user_id: user.id}, Rails.application.secrets.secret_key_base, 'HS256') }
  let(:headers) { { 'Authorization': "Bearer #{jwt_token}" } }
  describe '#index' do
    before { get '/employees' }

    it 'returns http success' do
      expect(response).to have_http_status(:ok)    
    end

    it 'assigns @employees' do
      expect(employees).to eq(Employee.all)
    end
  end

  describe '#create' do
    context 'with valid params' do
      let(:valid_attributes) { { full_name: 'Nice people', email: 'nice.people@creditshelft.com', department_id: 1 } }
      before do 
        allow(ManagerLunch::SetLastEmployee).to receive(:call).with(MysteryLunch::CURRENT_YEARMONTH)        
        post '/employees', params: { employee: valid_attributes }, headers: headers 
      end
      it 'creates a new Employee' do        
        expect(Employee.count).to eq(1)
      end

      it 'returns a success response' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe '#destroy' do    
    context 'when employee exists' do
      before do
        allow(ManagerLunch::HandleRemainingEmployees).to receive(:call).with(employee.id)        
        delete "/employees/#{employee.id}", headers: headers
      end

      it 'inactivate the employee' do
        employee.reload
        expect(employee.inactivated).to eq(1)
      end

      it 'returns a success response' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when employee doesnt exists' do
      before { delete '/employees/100', headers: headers }

      it 'returns a error response' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe '#update' do
    let(:valid_attributes) { { full_name: 'Nice people', email: 'nice.people@creditshelft.com', department_id: 1 } }
    let(:invalid_attributes) { { full_name: '', email: '', department_id: 1 } }

    context 'with valid attributes' do
      before { put "/employees/#{employee.id}", params: { id: employee.id, employee: valid_attributes }, headers: headers }
      

      it 'updates the employee' do
        employee.reload
        valid_attributes.each do |attribute, value|
          expect(employee.send(attribute)).to eq(value)
        end
      end

      it 'returns a success response' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid attributes' do
      before { put "/employees/#{employee.id}", params: { id: employee.id, employee: invalid_attributes }, headers: headers }
        
      it 'returns an error response' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
