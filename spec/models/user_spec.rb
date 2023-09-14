# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:memberships).inverse_of(:user) }
    it { is_expected.to have_many(:teams).through(:memberships) }
    it { is_expected.to have_many(:roles).through(:memberships) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:identifier) }
  end
end
