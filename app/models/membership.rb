# frozen_string_literal: true

class Membership < ApplicationRecord
  belongs_to :user, inverse_of: :memberships
  belongs_to :team, inverse_of: :memberships
  belongs_to :role, inverse_of: :memberships
end
