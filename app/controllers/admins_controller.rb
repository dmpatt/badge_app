class AdminsController < ApplicationController
	
  def show
	  @admin = Admin.find(params[:id])
	  @title = @admin.name
  end		
	
  def new
	  @admin = Admin.new
	  @title = "Reg Admin"
  end
  
  def create
	if user_signed_in?
		user = current_user
		if !user.nil? && User.authenticate(user.email, params[:password])
			#params[:name] = user.name
			#params[:email] = user.email
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

end
