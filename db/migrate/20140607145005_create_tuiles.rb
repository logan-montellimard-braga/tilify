class CreateTuiles < ActiveRecord::Migration
  def change
    create_table :tuiles do |t|
      t.string :titre
      t.string :lien
      t.string :image
      t.text :description
      t.string :type

      t.timestamps
    end
  end
end
