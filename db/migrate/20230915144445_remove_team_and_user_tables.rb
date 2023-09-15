# frozen_string_literal: true

class RemoveTeamAndUserTables < ActiveRecord::Migration[7.0]
  def up
    drop_table :teams
    drop_table :users
  end

  def down
    create_table :teams do |t|
      t.string :name, null: false

      t.timestamps
    end

    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
