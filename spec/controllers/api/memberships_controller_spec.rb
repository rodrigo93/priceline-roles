# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::MembershipsController, type: :controller do
  describe 'POST /create' do
    subject { post :create, params: { membership: membership_params }, format: :json }

    context 'with valid params' do
      let(:role) { create :role }
      let(:membership_params) do
        {
          user_id: 'fd282131-d8aa-4819-b0c8-d9e0bfb1b75c',
          team_id: '7676a4bf-adfe-415c-941b-1739af07039b',
          role_id: role.id
        }
      end

      it 'creates a new membership' do
        subject

        expect(response).to have_http_status(:created)
        expect(response.parsed_body['user_id']).to eq 'fd282131-d8aa-4819-b0c8-d9e0bfb1b75c'
        expect(response.parsed_body['team_id']).to eq '7676a4bf-adfe-415c-941b-1739af07039b'
        expect(response.parsed_body['role_id']).to eq role.id
      end
    end

    context 'with invalid params' do
      let(:membership_params) { { name: '', team_id: nil } }

      it 'returns unprocessable entity with an error message' do
        subject

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body['error']).to eq(
          "Validation failed: Role must exist, Team can't be blank, User can't be blank"
        )
      end
    end

    context "when the role doesn't exist" do
      let(:membership_params) { { user_id: '123', team_id: '456', role_id: 999 } }

      it 'returns unprocessable entity with an error message' do
        subject

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body['error']).to eq('Validation failed: Role must exist')
      end
    end

    context 'when the user is already a member of the team' do
      let(:role) { create :role }
      let(:membership_params) do
        {
          user_id: 'fd282131-d8aa-4819-b0c8-d9e0bfb1b75c',
          team_id: '7676a4bf-adfe-415c-941b-1739af07039b',
          role_id: role.id
        }
      end

      before { create :membership, membership_params }

      it 'returns unprocessable entity with an error message' do
        subject

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body['error']).to eq('Validation failed: User has already been assigned to this team')
      end
    end
  end

  describe 'GET /show' do
    subject { get :show, params: { id: membership_id }, format: :json }

    let(:membership)    { create :membership }
    let(:membership_id) { membership.id }

    it 'returns the membership' do
      subject

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['user_id']).to eq membership.user_id
      expect(response.parsed_body['team_id']).to eq membership.team_id
      expect(response.parsed_body['role_id']).to eq membership.role_id
    end

    context 'when the membership does not exist' do
      let(:membership_id) { 123 }

      it 'returns not found with an error message' do
        subject

        expect(response).to have_http_status(:not_found)
        expect(response.parsed_body['error']).to eq("Couldn't find Membership with 'id'=123")
      end
    end
  end

  describe 'GET /role' do
    subject { get :role, params: { id: membership_id }, format: :json }

    let(:membership)    { create :membership }
    let(:membership_id) { membership.id }

    it 'returns the role' do
      subject

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['name']).to eq membership.role.name
    end

    context 'when the membership does not exist' do
      let(:membership_id) { 890 }

      it 'returns not found with an error message' do
        subject

        expect(response).to have_http_status(:not_found)
        expect(response.parsed_body['error']).to eq("Couldn't find Membership with 'id'=890")
      end
    end
  end
end
