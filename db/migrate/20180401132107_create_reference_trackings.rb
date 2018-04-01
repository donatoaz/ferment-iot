class CreateReferenceTrackings < ActiveRecord::Migration[5.1]
  def change
    create_table :reference_trackings do |t|
      t.decimal :value, precision: 6, scale: 2
      t.datetime :target_datetime
      t.references :control_loop, foreign_key: true

      t.timestamps
    end
  end
end
