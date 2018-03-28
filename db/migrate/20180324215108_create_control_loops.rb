class CreateControlLoops < ActiveRecord::Migration[5.1]
  def change
    create_table :control_loops do |t|
      t.string :name
      t.integer :mode
      t.decimal :reference, precision: 6, scale: 3
      t.string :parameters
      t.references :sensor, foreign_key: true
      t.references :actuator, foreign_key: true

      t.timestamps
    end
  end
end
