# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::RolesController, type: :controller do
  shared_examples 'returning not found' do
    it do
      subject

      expect(response).to have_http_status(:not_found)
      expect(response.parsed_body['error']).to match(/Couldn't find Role with/)
    end
  end

  describe 'GET /index' do
    subject { get :index, params: { page:, per: }, format: :json }

    context 'when there are no roles' do
      let(:page) { 1 }
      let(:per) { 10 }

      it 'returns an empty list' do
        subject

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body).to be_empty
      end
    end

    context 'when there are less than `per` amount of roles' do
      let!(:roles) { create_list(:role, 2) }
      let(:page)   { 1 }
      let(:per)    { 3 }

      it 'returns a list of roles' do
        subject

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body.size).to eq(2)
      end
    end

    context 'when there are more than `per` amount of roles' do
      let!(:roles) { create_list(:role, 3) }
      let(:page)   { 1 }
      let(:per)    { 2 }

      it 'returns a paginated list of roles' do
        subject

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body.size).to eq(per)
      end

      it 'returns the next page of roles when specifying a different page' do
        get :index, params: { page: 2, per: }, format: :json

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body.size).to eq(1)
      end
    end

    context 'when pagination params are not specified' do
      let!(:roles) { create_list(:role, 3) }
      let(:page)   { nil }
      let(:per)    { nil }

      it 'returns a paginated list of roles' do
        subject

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body.size).to eq(3)
      end
    end

    context 'when pagination params are of wrong type' do
      let!(:roles) { create_list(:role, 2) }
      let(:page)   { 'asdsad' }
      let(:per)    { 'aaaaaa' }

      it 'returns a paginated list of roles' do
        subject

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body.size).to eq(2)
      end
    end
  end

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
      let(:role) { create(:role) }
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
      let(:role_params) { { id: 999 } }

      it_behaves_like 'returning not found'
    end
  end

  describe 'GET /memberships' do
    subject { get :memberships, params: role_params, format: :json }

    context 'when the role exists' do
      let(:role) { create(:role) }
      let(:role_params) do
        { id: role.id }
      end

      context 'with no memberships' do
        it 'returns an empty list' do
          subject

          expect(response).to have_http_status(:ok)
          expect(response.parsed_body).to be_empty
        end
      end

      context 'with memberships' do
        let!(:memberships) { create_list(:membership, 2, role:) }

        it 'returns a list of memberships' do
          subject

          expect(response).to have_http_status(:ok)
          expect(response.parsed_body.size).to eq(2)
        end
      end

      context 'with pagination' do
        let!(:memberships) { create_list(:membership, 2, role:) }
        let(:page) { 1 }
        let(:per) { 1 }
        let(:role_params) do
          { id: role.id, page:, per: }
        end

        it 'returns a paginated list of memberships' do
          subject

          expect(response).to have_http_status(:ok)
          expect(response.parsed_body.size).to eq(per)
        end
      end
    end

    context 'when the role does not exist' do
      let(:role_params) { { id: 999 } }

      it_behaves_like 'returning not found'
    end
  end
end
