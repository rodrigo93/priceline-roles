# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:memberships).inverse_of(:role) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
