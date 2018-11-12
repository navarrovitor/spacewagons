class CreateLaps < ActiveRecord::Migration[5.2]
  def change
    create_table :laps do |t|
      t.integer :lap_num
      t.integer :combat_killers, array: true, default: []
      t.integer :combat_victims, array: true, default: []
      t.integer :crash_victims, array: true, default: []
      t.integer :positions, array: true, default: []
      t.integer :points, array: true, default: []
      t.references :race, foreign_key: true

      t.timestamps
    end
  end
end
