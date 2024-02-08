class CreateVenues < ActiveRecord::Migration[7.1]
  def change
    create_table :venues do |t|
      t.string :name
      t.string :venue_type
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
