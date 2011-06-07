class SessionsController < ApplicationController

	def new
		@title = "Sign in"
	end
	
	def create
		user = User.authenticate(params[:session][:email],
						   params[:session][:email])
		admin = Admin.authenticate(params[:session][:email],
							params[:session][:email])
		if user.nil? && admin.nil?
			flash.now[:error] = "Invlaid email/password combination."
			@title = "Sign in"
			render 'new'
		elsif user.nil?
			sign_in_admin admin
			redirect_to admin
		elsif admin.nil?
			sign_in_user user
			redirect_to user
		else
			sign_in_admin admin
			sign_in_user user
			redirect_to user
		end
	end
	
	def destroy
		if user_signed_in?
			sign_out_user
		end
		if admin_signed_in?
			sign_out_admin
		end
		redirect_to root_path
	end

end
