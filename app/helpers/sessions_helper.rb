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
	
end
