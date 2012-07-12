class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :attendee_id
      t.integer :event_id

      t.timestamps
    end

    add_index :tickets, :attendee_id
    add_index :tickets, :event_id

    add_index :tickets, [:attendee_id, :event_id], unique: true
  end
end
