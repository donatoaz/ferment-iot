class CreateSensors < ActiveRecord::Migration[5.1]
  def change
    create_table :sensors do |t|
      t.string :name
      t.string :write_key

      t.timestamps
    end
    add_index :sensors, :write_key, unique: true
  end
end
