# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :memberships, inverse_of: :team
  has_many :users, through: :memberships
  has_many :roles, through: :memberships

  validates :name, presence: true
end
