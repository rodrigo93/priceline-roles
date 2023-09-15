# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/roles', type: :request do
  path '/api/roles/{id}/memberships' do
    parameter name: 'id', in: :path, type: :string, description: 'ID of Role'

    get "Fetch role's membership" do
      tags 'Roles'
      produces 'application/json'

      response(200, 'Returns related membership') do
        let(:id) { create(:role).id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(404, 'Role not found') do
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

  path '/api/roles' do
    get 'List roles' do
      tags 'Roles'
      produces 'application/json'
      parameter name: :page, in: :query, type: :integer, description: 'Page number', required: false
      parameter name: :per, in: :query, type: :integer, description: 'Items per page', required: false

      response(200, 'successful') do
        let!(:roles) { create_list(:role, 3) }

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

    post 'Create a role' do
      tags 'Roles'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :role, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: ['name']
      }

      response(201, 'successful') do
        let(:role) { build :role }

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

  path '/api/roles/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'Role ID'

    get 'Fetch a single role' do
      tags 'Roles'
      produces 'application/json'

      response(200, 'Role found') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 create_at: { type: :string },
                 updated_at: { type: :string }
               },
               required: %w[id name]

        let(:id) { create(:role).id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(404, 'Role not found') do
        let(:id) { 1234 }

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
