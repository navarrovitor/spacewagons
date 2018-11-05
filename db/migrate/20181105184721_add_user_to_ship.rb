class AddUserToShip < ActiveRecord::Migration[5.2]
  def change
    add_reference :ships, :user, foreign_key: true
  end
end
