# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Membership, type: :model do
  describe 'associations' do
    subject(:membership) { FactoryBot.create :membership }

    it { is_expected.to belong_to(:role).inverse_of(:memberships) }

    it do
      is_expected.to validate_uniqueness_of(:user_id)
        .scoped_to(:team_id)
        .with_message('has already been assigned to this team')
        .case_insensitive
    end

    it { is_expected.to validate_presence_of(:team_id) }
  end
end
