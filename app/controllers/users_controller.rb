class UsersController < ApplicationController
	
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
		sign_in_user @user #####change?
		flash[:success] = "Welcome to the Badge App!"
		redirect_to @user
	else
		@title = "Register"
		render 'new'
	end
  end

end
