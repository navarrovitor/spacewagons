class CreateWagonShips < ActiveRecord::Migration[5.2]
  def change
    create_table :wagon_ships do |t|
      t.string :name
      t.string :category

      t.timestamps
    end
  end
end
