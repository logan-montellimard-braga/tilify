class AddUserIdToTuile < ActiveRecord::Migration
  def change
    add_column :tuiles, :user_id, :integer
  end
end
