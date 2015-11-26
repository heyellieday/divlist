class TwitterProfile < ActiveRecord::Base
	has_many :tweets
	has_many :posts, through: :tweets
	belongs_to :user
end
