class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.integer :interactable_id
      t.string :interactable_type
      t.string :key
      t.string :value

      t.timestamps
    end

    add_index :interactions, :interactable_id
    add_index :interactions, :interactable_type
    add_index :interactions, [:interactable_id, :interactable_type]
    add_index :interactions, :key
    add_index :interactions, :value
    add_index :interactions, [:key, :value]
    add_index :interactions, [:interactable_id, :interactable_type, :key, :value], name: :complex_index
  end
end
