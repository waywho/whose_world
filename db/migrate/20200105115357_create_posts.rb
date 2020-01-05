class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.string :slug
      t.references :parentable, polymorphic: true, index: true

      t.timestamps
    end
    add_index :posts, :slug, unique: true
    add_index :posts, :title
  end
end
