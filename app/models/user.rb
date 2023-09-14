# frozen_string_literal: true

class User < ApplicationRecord
  has_many :memberships, inverse_of: :user, dependent: :destroy
  has_many :teams, through: :memberships
  has_many :roles, through: :memberships

  validates :identifier, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
end
