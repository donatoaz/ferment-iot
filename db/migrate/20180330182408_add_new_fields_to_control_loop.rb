class AddNewFieldsToControlLoop < ActiveRecord::Migration[5.1]
  def change
    add_column :control_loops, :next_run, :timestamp
    add_column :control_loops, :sampling_rate, :integer
  end
end
