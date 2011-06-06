class AdminsController < ApplicationController
	
  def show
	  @admin = Admin.find(params[:_id])
	  @title = @user.name
  end		
	
  def new
	  @admin = Admin.new
	  @title = "Reg Admin"
  end
  
  def create
	@admin = Admin.new(params[:admin])
	if @admin.save
		  redirect_to @user
	else
		@title = "RegAdmin"
		render 'new'
	end
  end  

end
