# frozen_string_literal: true

class CreateMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true # Automatically creates an index
      t.references :team, null: false, foreign_key: true # Automatically creates an index
      t.references :role, null: false, foreign_key: true # Automatically creates an index

      t.timestamps
    end
  end
end
