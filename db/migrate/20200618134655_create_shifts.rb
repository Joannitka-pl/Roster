# frozen_string_literal: true

class CreateShifts < ActiveRecord::Migration[6.0]
  def change
    create_table :shifts do |t|
      t.datetime :date
      t.integer :hour
      t.integer :studio
      t.integer :user_id
    end
  end
end
