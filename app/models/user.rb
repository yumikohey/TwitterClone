class User < ActiveRecord::Base

	#defined a class method
	class << self
		def from_omniauth(auth_hash)
			# check if the login user is in DB, if not, create a new account.
			user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
			user.name = auth_hash['info']['name']
			user.location = auth_hash['info']['location']
			user.image_url = auth_hash['info']['image']
			user.url = auth_hash['info']['urls']['Twitter']
			user.oauth_token = auth_hash['credentials']['token']
			user.oauth_secret = auth_hash['credentials']['secret']
			user.save!
			user
		end
	end

	def tweet(tweet)
		client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = ENV["TWITTER_KEY"]
		  config.consumer_secret     = ENV["TWITTER_SECRET"]
		  config.access_token        = oauth_token
		  config.access_token_secret = oauth_secret
		end
		client.update(tweet)
	end

	def timeline(username)
		client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = ENV["TWITTER_KEY"]
		  config.consumer_secret     = ENV["TWITTER_SECRET"]
		  config.access_token        = oauth_token
		  config.access_token_secret = oauth_secret
		end
		client.user_timeline(username)
	end
	
end
