# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:memberships).inverse_of(:user) }
    it { is_expected.to have_many(:teams).through(:memberships) }
    it { is_expected.to have_many(:roles).through(:memberships) }
  end

  describe 'validations' do
    subject { FactoryBot.create :user }

    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:identifier) }
    it { is_expected.to validate_uniqueness_of(:identifier).case_insensitive }
  end
end
