class AdminsController < ApplicationController
	
  def show
	  @admin = Admin.find(params[:_id])
	  @title = @user.name
  end		
	
  def new
	  @title = "Reg Admin"
  end

end
