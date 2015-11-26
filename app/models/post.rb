class Post < ActiveRecord::Base
		extend FriendlyId
	  friendly_id :title, use: :slugged

	  belongs_to :ownable, polymorphic: true
		belongs_to :belongable, polymorphic: true
	  has_one :tweet
	  has_one :twitter_profile, through: :tweet
end
