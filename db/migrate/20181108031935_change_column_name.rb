class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :expeditions, :exp_left
  end
end
