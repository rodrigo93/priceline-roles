# frozen_string_literal: true

class User < ApplicationRecord
  has_many :memberships, inverse_of: :user, dependent: :destroy
  has_many :teams, through: :memberships
  has_many :roles, through: :memberships

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  validates :name, presence: true
end
