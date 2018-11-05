class AddUserToParts < ActiveRecord::Migration[5.2]
  def change
    add_reference :parts, :user, foreign_key: true
  end
end
