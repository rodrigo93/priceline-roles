# frozen_string_literal: true

class AddUniqueConstraintToUserIdentifier < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :identifier, unique: true
  end
end
