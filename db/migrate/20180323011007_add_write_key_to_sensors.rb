class AddWriteKeyToSensors < ActiveRecord::Migration[5.1]
  def change
    add_column :sensors, :write_key, :string
  end
  add_index :sensors, :write_key, unique: true
end
