class AddPicToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :pic, :string
  end
end
