require 'rest-client'
require 'json'
require 'awesome_print'
class TwitterStream
	def initialize

	end

	def stream_with_keyword(keyword)
		TweetStream::Client.new.track(keyword) do |status|
		  Post.create(content: "#{status.text}") if status.is_a?(Twitter::Tweet)
		end
	end
end