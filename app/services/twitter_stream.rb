require 'rest-client'
require 'json'
require 'awesome_print'
class TwitterStream
	def initialize

	end

	def stream_with_keyword(keyword)
		TweetStream::Client.new.on_error do |message|
		  puts message
		end.track(keyword) do |status|

			if status.is_a?(Twitter::Tweet) && status.text[0..1].exclude?("RT") && Tweet.find_by(twitter_id: status[:id]).nil?
				profile = TwitterProfile.find_or_create_by(twitter_id: status.user[:id].to_s)
				https_url = status.user[:profile_image_url_https].to_s
				http_url = status.user[:profile_image_url].to_s
				https_url.slice!('_normal')
				http_url.slice!('_normal')

				profile.update(name: status.user[:name], screen_name: status.user[:screen_name], description: status.user[:description], profile_image_url_https: https_url,  profile_image_url: http_url, location: status.user[:location])
				post = Post.create()
				tweet = Tweet.create(text: status.text, post: post, twitter_profile: profile, url: status.url, twitter_id: status[:id].to_s)	
			end
		  #Post.create(content: "#{status.text}", source: "#{status.source}") if status.is_a?(Twitter::Tweet)
		end
	end
end