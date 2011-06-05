require 'digest'

class User
  include MongoMapper::Document

email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

attr_accessor :password
attr_accessor :password_confirmation

key :name, String, :length => { :maximum => 50 }
key :email, String  
key :encrypted_password, String
key :salt, String
timestamps!

validates_presence_of :name, :email, :password
validates_uniqueness_of :email, :case_sensitive => false 
validates_format_of :email, :with =>email_regex 
validates :password, :confirmation => true, :length => { :within => 6..40 }

before_save :encrypt_password

def has_password? (submitted_password)
	encrypted_password == encrypt(submitted_password)
end

def self.authenticate(email, submitted_password)
	user = find_by_email(email)
	return nil if user.nil?
	return user if user.has_password?(submitted_password)
end

private

def encrypt_password
	self.salt = make_salt if new?
	self.encrypted_password = encrypt(password)
end

def encrypt(string)
	secure_hash("#(salt)--#(string)")
end

def make_salt
	secure_hash("#(Time.now.etc)--#(password)")
end

def secure_hash(string)
	Digest::SHA2.hexdigest(string)
end

end
