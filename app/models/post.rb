class Post < ActiveRecord::Base
		extend FriendlyId
	  friendly_id :title, use: :slugged

	  belongs_to :ownable, polymorphic: true
		belongs_to :belongable, polymorphic: true
	  has_many :favorites
	  has_many :upvotes
end
