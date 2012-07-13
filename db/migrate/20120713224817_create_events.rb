class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :eventbrite_xid
      t.string :name
      t.string :url
      t.datetime :start
      t.datetime :end
      t.string :venue_name
      t.string :venue_url

      t.timestamps
    end

    add_index :events, :eventbrite_xid
  end
end
