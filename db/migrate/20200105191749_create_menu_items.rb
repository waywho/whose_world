class CreateMenuItems < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_items do |t|
      t.string :type
      t.references :navigation, polymorphic: true, index: true
      t.integer :row_order

      t.timestamps
    end
    add_index :menu_items, :row_order
  end
end
