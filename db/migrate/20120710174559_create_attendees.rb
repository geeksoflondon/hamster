class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.string :first_name
      t.string :last_name
      t.string :name
      t.string :phone_number
      t.string :twitter
      t.integer :tshirt
      t.text :diet
      t.integer :type
      t.boolean :public
      t.string :barcode
      t.text :notes

      t.timestamps
    end

    add_index :attendees, :name
    add_index :attendees, :barcode

    create_table :emails do |t|
      t.string :address
      t.belongs_to :attendee

      t.timestamps
    end

    add_index :emails, :address
    add_index :emails, :attendee_id
  end
end
