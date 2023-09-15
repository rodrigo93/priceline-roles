# frozen_string_literal: true

class Membership < ApplicationRecord
  belongs_to :role, inverse_of: :memberships

  validates :team_id, presence: true
  validates :user_id,
            presence: true,
            uniqueness: { scope: :team_id, case_sensitive: false }
end
