# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :memberships, inverse_of: :role, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
