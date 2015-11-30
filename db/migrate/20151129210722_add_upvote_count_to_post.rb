class AddUpvoteCountToPost < ActiveRecord::Migration
  def change
    add_column :posts, :upvote_count, :integer, default: 0
  end
end
