class RenameTypeColumn < ActiveRecord::Migration
  def change
    rename_column :tuiles, :type, :forme
  end
end
