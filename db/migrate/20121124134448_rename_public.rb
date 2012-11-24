class RenamePublic < ActiveRecord::Migration
  def change
    rename_column :attendees, :public, :is_public
  end
end
