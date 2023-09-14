# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Membership, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user).inverse_of(:memberships) }
    it { is_expected.to belong_to(:team).inverse_of(:memberships) }
    it { is_expected.to belong_to(:role).inverse_of(:memberships) }
  end
end
