class AddProgressIntToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :progress, :integer, default: 0
  end
end
