class Post < ActiveRecord::Base
	include AASM
	extend FriendlyId
	friendly_id :title, use: :slugged

	  belongs_to :ownable, polymorphic: true
		belongs_to :belongable, polymorphic: true
	  has_one :tweet
	  has_one :twitter_profile, through: :tweet
	  has_many :upvotes

	  attr_accessor :current_user


	  aasm do
	     state :pending, :initial => true
	     state :approved

	     event :approve do
	       transitions :from => [:pending], :to => :approved
	     end
	   end

	scope :approved, -> { where(:aasm_state => "approved") }
	scope :pending, -> { where(:aasm_state => "pending") }

	def is_upvoted
		if current_user.present?
			user ||= current_user
			user.upvotes.find_by(post_id: id).present?
		else
			false
		end
	end
end
