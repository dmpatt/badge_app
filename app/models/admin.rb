require 'digest'

class Admin
  include MongoMapper::Document

email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

attr_accessor :password

key :name, String, :length => { :maximum => 50 }
key :email, String  
key :encrypted_password, String
key :salt, String
timestamps!

validates_presence_of :name, :email, :password
validates_uniqueness_of :email, :case_sensitive => false 
validates_format_of :email, :with =>email_regex
validates :password, :length => { :within => 6..40 }

before_save :encrypt_password

def has_password? (submitted_password)
	encrypted_password == encrypt(submitted_password)
end

def self.authenticate(email, submitted_password)
	admin = find_by_email(email)
	return nil if admin.nil?
	return admin if admin.has_password?(submitted_password)
end

def self.authenticate_with_salt(id, cookie_salt)
	admin = find_by_id(id)
	(admin && admin.salt == cookie_salt) ? admin :nil
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
