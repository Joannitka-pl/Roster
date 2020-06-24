class RemoveUserFromShift < ActiveRecord::Migration[6.0]
  def change
    remove_column :shifts, :user_id, :integer
  end
end
