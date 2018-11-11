class CreateMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :maps do |t|
      t.string :name
      t.integer :acc_mult
      t.integer :spd_mult

      t.timestamps
    end
  end
end
