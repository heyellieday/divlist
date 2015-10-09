class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :slug, index: true
      t.text :content
      t.text :source
      t.string :type
      t.references :belongable, polymorphic: true, index: true
      t.references :ownable, polymorphic: true, index: true

      t.timestamps null: false

    end
  end
end