# frozen_string_literal: true

class User < ApplicationRecord
  has_many :memberships, inverse_of: :user
  has_many :teams, through: :memberships
  has_many :roles, through: :memberships

  validates :identifier, presence: true
  validates :name, presence: true
end
