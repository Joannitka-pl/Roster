class RenameDateAndHour < ActiveRecord::Migration[6.0]
  def change
    remove_column :shifts, :hour, :integer
    add_column    :shifts, :duration, :integer
    rename_column :shifts, :date, :starting_at
  end
end
