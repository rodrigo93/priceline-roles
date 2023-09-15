# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/memberships', type: :request do
  path '/api/memberships/{id}/role' do
    parameter name: 'id', in: :path, type: :string, description: 'Membership ID'

    get "Fetch membership's role" do
      tags 'Memberships'
      produces 'application/json'

      response(200, 'Membership found') do
        let!(:id) { create(:membership).id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end

      response(404, 'Membership not found') do
        let(:id) { '999' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end
  end

  path '/api/memberships' do
    post 'Creates a membership' do
      tags 'Memberships'
      consumes 'application/json'
      parameter name: :membership, in: :body, schema: {
        type: :object,
        properties: {
          role_id: { type: :string },
          user_id: { type: :string },
          team_id: { type: :string }
        },
        required: %w[role_id user_id team_id]
      }

      response(201, 'Membership created') do
        let!(:membership) { build(:membership) }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(422, 'Membership not created due to invalid attributes or error') do
        let(:membership) { { team_id: nil } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/memberships/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'Membership ID'

    get 'Fetch membership' do
      tags 'Memberships'
      produces 'application/json'

      response(200, 'Membership found') do
        let!(:id) { create(:membership).id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(404, 'Membership not found') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
