# frozen_string_literal: true

class ModifyMembershipTable < ActiveRecord::Migration[7.0]
  def change
    # rubocop:disable Rails/NotNullColumn
    change_table :memberships, bulk: true do |_|
      # Add string columns for team_id and user_id
      add_column :memberships, :team_id, :string, null: false
      add_column :memberships, :user_id, :string, null: false

      # Add a unique constraint to ensure a user can have one role per team
      add_index :memberships, %i[team_id user_id], unique: true
    end
    # rubocop:enable Rails/NotNullColumn
  end
end
