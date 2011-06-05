class UsersController < ApplicationController
	
  def show
	  @user = User.find(params[:_id])
	  @title = @user.name
  end	
	
  def new
	  @title = "Register"
  end

end
