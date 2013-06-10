class AddEmailToAttendee < ActiveRecord::Migration
  def change
  	add_column :attendees, :email, :string
  end
end
