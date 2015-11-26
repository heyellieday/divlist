class CreateTwitterProfiles < ActiveRecord::Migration
  def change
    create_table :twitter_profiles do |t|
      t.string :name
      t.string :twitter_id
      t.string :screen_name
      t.string :description
      t.string :location
      t.text :profile_image_url
      t.text :profile_image_url_https

      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
