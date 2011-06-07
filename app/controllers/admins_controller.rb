class AdminsController < ApplicationController
	before_filter :authenticate, :only => :index
	before_filter :admin_user, :only => :destroy
	
	def show
		@admin = Admin.find(params[:id])
		@title = @admin.name
	end		
	
	def new
		@admin = Admin.new
		@title = "Reg Admin"
	end
  
	def index
		@title = "Admin Index"
		@admins = Admin.paginate(:page => params[:page])
	end
  
	def create
		if user_signed_in?
			user = current_user
			if !user.nil? && User.authenticate(user.email, params[:password])
				@admin = Admin.new(params[:admin])
				if @admin.save
					sign_in_admin @admin
					flash[:success] = "Badge App Administrator!"
					return redirect_to @admin
				end		
			end
		end
		@title = "Reg Admin"
		render 'new'	
	end  

	def destroy
		Admin.find(params[:id]).destroy
		flash[:success] = "Admin deleted"
	end	
	
	private
	
	def authenticate
		deny_access unless admin_signed_in?
	end	
	
	def admin_user
		@admin = Admin.find(params[:id])
		redirect_to(root_path) unless current_admin?(@admin)
	end	


end
