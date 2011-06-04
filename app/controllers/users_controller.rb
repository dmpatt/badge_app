class UsersController < ApplicationController
	
  def show
	  @user = User.find(params[:email])
  end	
	
  def new
	  @title = "Register"
  end

end
