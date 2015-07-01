class SessionsController < ApplicationController
	def create
		begin
			@user = User.from_omniauth(request.env['omniauth.auth'])
			session[:user_id] = @user.id
			flash[:success] = "Successfully login."
		rescue
			flash[:warning] = "Please try again, we failed to authenticate you"
		end
		redirect_to root_path
	end

	def destroy
		if current_user
			session.delete(:user_id)
			flash[:success] = 'Good bye'
		end
		redirect_to root_path
	end
end
