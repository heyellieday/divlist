class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :text
      t.references :twitter_profile, index: true, foreign_key: true
      t.text :url
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
