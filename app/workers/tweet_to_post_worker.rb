class SocialCountWorker
  include Sidekiq::Worker

  def perform(post_url, post_slug)
  	Sidekiq.redis do |conn|
  		count = SocialCount.get(post_url)
	    post = Post.friendly.find(post_slug)
	    post.social_count = count
			post.save
		end
  end
end