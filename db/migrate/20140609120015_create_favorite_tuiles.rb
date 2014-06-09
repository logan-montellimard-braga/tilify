class CreateFavoriteTuiles < ActiveRecord::Migration
  def change
    create_table :favorite_tuiles do |t|
      t.integer :tuile_id
      t.integer :user_id

      t.timestamps
    end
  end
end
