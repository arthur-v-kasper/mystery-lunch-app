# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employees', type: :request do
  let(:employee) { create(:employee) }
  let(:employees) { create_list(:employee, 3) }

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
      let(:valid_attributes) { attributes_for(:employee) }
      before { post '/employees', params: { employee: valid_attributes } }
      xit 'creates a new Employee' do
        expect { post '/employees', params: { employee: valid_attributes } }.to change { Employee.count }.by(1)
        binding.break
        expect(Employee.count).to eq(1)
      end

      xit 'calls ManagerLunch::SetLastEmployee.call' do
        expect(ManagerLunch::SetLastEmployee).to receive(:call)
        post '/employees', params: { employee: valid_attributes }
      end

      xit 'returns a success response' do
        post '/employees', params: { employee: valid_attributes }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe '#destroy' do
    context 'when employee exists' do
      before { delete "/employees/#{employee.id}" }

      it 'inactivate the employee' do
        employee.reload
        expect(employee.inactivated).to eq(1)
      end

      it 'returns a success response' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when employee doesnt exists' do
      before { delete '/employees/100' }

      it 'returns a error response' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe '#update' do
    let(:valid_attributes) { { full_name: 'Nice people', email: 'nice.people@creditshelft.com', department_id: 1 } }
    let(:invalid_attributes) { { full_name: '', email: '', department_id: 1 } }

    context 'with valid attributes' do
      before { put "/employees/#{employee.id}", params: { id: employee.id, employee: valid_attributes } }

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
      before { put "/employees/#{employee.id}", params: { id: employee.id, employee: invalid_attributes } }

      it 'returns an error response' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
