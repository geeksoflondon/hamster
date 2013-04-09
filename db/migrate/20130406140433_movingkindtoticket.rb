class Movingkindtoticket < ActiveRecord::Migration
  def change
    remove_column :attendees, :kind
    add_column :tickets, :kind, :integer
  end
end
