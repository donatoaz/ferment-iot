class CreateActuators < ActiveRecord::Migration[5.1]
  def change
    create_table :actuators do |t|
      t.string :name
      t.string :write_key
      t.integer :output, default: 0

      t.timestamps
    end
    add_index :actuators, :write_key, unique: true
  end
end
