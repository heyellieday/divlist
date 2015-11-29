class TweetStreamWorker
  include Sidekiq::Worker

  def perform
  	Sidekiq.redis do |conn|
  		twitter_stream = TwitterStream.new
  		twitter_stream.stream_with_keyword(ENV["tweetstream_keyword"])
		end
  end
end