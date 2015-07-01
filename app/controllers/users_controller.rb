class UsersController < ApplicationController

	def show
		if current_user
			@timeline = current_user.timeline(current_user)
		end
	end

	def tweet
		current_user.tweet(params[:tweet][:content])
		redirect_to root_path
	end

end
