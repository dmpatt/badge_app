class BadgesController < ApplicationController
	before_filter :authenticate, :only => :index
	before_filter :admin_user, :only => [:destroy, :new, :edit, :update]
	
	def show
		@badge = Badge.find(params[:id])
		@title = @badge.title
	end	
	
	def new
		@badge = Badge.new
		@title = "Create Badge"
	end

	def create
		@badge = Badge.new(params[:badge])
		if @badge.save
			flash[:success] = "Created Badge!"
			redirect_to @badge
		else
			@title = "Create Badge"
			render 'new'
		end
	end

	def edit
		@badge = Badge.find(params[:id])
		@title = "Edit Badge"
	end
	
	def update
		@badge = Badge.find(params[:id])
		if @badge.update_attributes(params[:badge])
			flash[:success] = "Badge Updated"
			redirect_to @badge
		else
			@title = "Edit Badge"
			render 'edit'
		end
	end
	
	def index
		@title = "Badge Index"
		@badges = Badge.paginate(:page => params[:page])
	end
	
	def destroy
		badge = Badge.find(params[:id])
		if badge
			badge.destroy
		end
		flash[:success] = "Badge Deleted"
	end	
	
	private
	
	def authenticate
		deny_access unless user_signed_in?
	end
	
	def admin_user
		redirect_to(root_path) unless admin_signed_in?
	end	
	
end