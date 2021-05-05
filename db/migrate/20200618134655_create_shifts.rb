# frozen_string_literal: true

class CreateShifts < ActiveRecord::Migration[6.0]
  def change
    create_table :shifts do |t|
      t.datetime :starting_at
      t.integer :studio
      t.integer :duration
    end
  end
end
