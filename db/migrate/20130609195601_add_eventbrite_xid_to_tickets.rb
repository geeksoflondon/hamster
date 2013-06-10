class AddEventbriteXidToTickets < ActiveRecord::Migration
  def change
  	add_column :tickets, :eventbrite_xid, :string
  end
end
