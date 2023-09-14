# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::RolesController, type: :controller do
  describe 'POST /create' do
    subject { post :create, params: { role: role_params }, format: :json }

    context 'with valid params' do
      let(:role_params) { { name: 'Admin' } }

      it 'creates a new role' do
        subject

        expect(response).to have_http_status(:created)
        expect(response.parsed_body['name']).to eq('Admin')
      end
    end

    context 'with invalid params' do
      let(:role_params) { { name: '' } }

      it 'returns unprocessable entity with an error message' do
        subject

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body).to eq({ 'error' => "Validation failed: Name can't be blank" })
      end
    end
  end

  describe 'GET /show' do
    subject { get :show, params: role_params, format: :json }

    context 'when the role exists' do
      let(:role) { FactoryBot.create(:role) }
      let(:role_params) do
        { id: role.id }
      end

      it 'returns a role' do
        subject

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body['name']).to eq(role.name)
      end
    end

    context 'when the role does not exist' do
      let(:role_params) do
        { id: 999 }
      end

      it 'returns not found with an error message' do
        subject

        expect(response).to have_http_status(:not_found)
        expect(response.parsed_body).to eq(
          { 'error' => "Couldn't find Role with 'id'=#{role_params[:id]}" }
        )
      end
    end
  end
end
