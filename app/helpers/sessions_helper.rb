module SessionsHelper
	#users
	def sign_in_user(user)
		cookies.permanent.signed[:remember_token_u] = [user.id, user.salt]
		self.current_user = user
	end
	
	def sign_out_user
		cookies.delete(:remember_token_u)
		self.current_user = nil
	end
	
	def current_user=(user)
		@current_user = user
	end
	
	def current_user
		@current_user ||= user_from_remember_token
	end
	
	def current_user?(user)
		user == current_user
	end
	
	def user_signed_in?
		!current_user.nil?
	end
	
	#admins
	def sign_in_admin(admin)
		cookies.permanent.signed[:remember_token_a] = [admin.id, admin.salt]
		self.current_admin = admin
	end
	
	def sign_out_admin
		cookies.delete(:remember_token_a)
		self.current_admin = nil
	end
	
	def current_admin=(admin)
		@current_admin = admin
	end
	
	def current_admin
		@current_admin ||= admin_from_remember_token
	end
	
	def admin_signed_in?
		!current_admin.nil?
	end	
	
	def deny_access
		store_location
		redirect_to signin_path, :notice => "Please sign in to access this page."
	end
	
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		clear_return_to
	end
	
	def put_badge(badge)
		@badge = badge
	end
	
	def get_badge
		@badge
	end
	
	private
	
		def user_from_remember_token
			User.authenticate_with_salt(*remember_token_u)
		end
		
		def admin_from_remember_token
			Admin.authenticate_with_salt(*remember_token_a)
		end		
		
		def remember_token_u
			cookies.signed[:remember_token_u] || [nil, nil]
		end
		
		def remember_token_a
			cookies.signed[:remember_token_a] || [nil, nil]
		end		
		
		def store_location
			session[:return_to] = request.fullpath
		end
		
		def clear_return_to
			session[:return_to] = nil
		end
	
end
