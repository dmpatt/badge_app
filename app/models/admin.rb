class Admin
  include MongoMapper::Document

email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

key :name, String, :length => { :maximum => 50 }
key :email, String  
timestamps!

validates_presence_of :name, :email
validates_uniqueness_of :email, :case_sensitive => false 
validates_format_of :email, :with =>email_regex

end
