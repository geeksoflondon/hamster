class AddCurrentToInteractions < ActiveRecord::Migration
  def change
    add_column :interactions, :current, :boolean, default: true
  end
end
