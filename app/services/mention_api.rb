require 'rest-client'
require 'json'
require 'awesome_print'
class MentionApi
	def initialize
		first_client = RestClient::Resource.new('https://api.mention.net/api/')
		body = first_client["accounts/me"].get(:Authorization => "Bearer #{ENV["mention_access_token"]}", :Accept => "application/json").body
		account = JSON.parse(body)
		path = account["_links"]["me"]["href"]
		body = RestClient.get("https://api.mention.net#{path}", {:Authorization => "Bearer #{ENV["mention_access_token"]}", :Accept => "application/json"}).body
		data = JSON.parse(body)
		account_id = data["account"]["id"]
		@client = RestClient::Resource.new("https://api.mention.net/api/accounts/#{account_id}")


	end
	def get_mentions(keyword, since_id)
		alert = get_alert_by_keyword(keyword)
		body = @client["alerts/#{alert['id']}/mentions?since_id=#{since_id}"].get(:Authorization => "Bearer #{ENV["mention_access_token"]}", :Accept => "application/json").body
		data = JSON.parse(body)
		ap data

	end
	private
		def get_alert_by_keyword(keyword)
			body = @client["alerts"].get(:Authorization => "Bearer #{ENV["mention_access_token"]}", :Accept => "application/json").body
			data = JSON.parse(body)
			alert = data["alerts"].find{|alert| alert["primary_keyword"] == keyword}
		end
end