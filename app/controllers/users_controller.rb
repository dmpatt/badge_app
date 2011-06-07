class UsersController < ApplicationController
	before_filter :authenticate, :only => [:index, :edit, :update]
	before_filter :correct_user, :only => [:edit, :update]
	before_filter :admin_user, :only => :destroy
	
	def show
		@user = User.find(params[:id])
		@title = @user.name
	end	
	
	def new
		@user = User.new
		@title = "Register"
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			sign_in_user @user 
			flash[:success] = "Welcome to the Badge App!"
			redirect_to @user
		else
			@title = "Register"
			render 'new'
		end
	end

	def edit
		@title = "Edit User"
	end
	
	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			if admin_signed_in?
				@admin = current_admin
				@admin.update_attributes(params[:user])
			end
			flash[:success] = "Profile Updated"
			redirect_to @user
		else
			@title = "Edit user"
			render 'edit'
		end
	end
	
	def index
		@title = "User Index"
		@users = User.paginate(:page => params[:page])
	end
	
	def destroy
		user = User.find(params[:id])
		if user
			admin = Admin.find_by_email(user.email)
			if admin
				admin.destroy
			end
			user.destroy
		end
		flash[:success] = "User deleted"
	end
	
	private
	
	def authenticate
		deny_access unless user_signed_in?
	end
	
	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_path) unless current_user?(@user)
	end
	
	def admin_user
		redirect_to(root_path) unless admin_signed_in?
	end
	

end
