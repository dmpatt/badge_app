class AdminsController < ApplicationController
	
  def show
	  @admin = Admin.find(params[:email])
  end		
	
  def new
	  @title = "Reg Admin"
  end

end
