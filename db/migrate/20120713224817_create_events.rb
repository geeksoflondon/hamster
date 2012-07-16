class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :venue_id
      t.string :eventbrite_xid
      t.string :name
      t.string :url
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end

    add_index :events, :eventbrite_xid
    add_index :events, :venue_id
  end
end
