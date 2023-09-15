# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:memberships).inverse_of(:role) }
  end

  describe 'validations' do
    subject { create :role }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end

  describe '.default' do
    subject { described_class.default }

    context 'when the default role exists' do
      let!(:default_role) { create :role, name: 'Developer' }

      it { is_expected.to eq default_role }
      it { expect { subject }.not_to change(described_class, :count) }
    end

    context 'when the default role does not exist' do
      it 'creates a new default role' do
        expect { subject }.to change(described_class, :count).by(1)
        expect(subject.name).to eq 'Developer'
      end
    end
  end
end
