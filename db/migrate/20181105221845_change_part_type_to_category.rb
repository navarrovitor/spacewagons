class ChangePartTypeToCategory < ActiveRecord::Migration[5.2]
  def change
    rename_column :parts, :type, :category
  end
end
