class CreateTenants < ActiveRecord::Migration[5.2]
  def change
    create_table :tenants do |t|
      t.string :name
      t.string :host
      t.references :user

      t.timestamps
    end
    add_index :tenants, :host
  end
end
