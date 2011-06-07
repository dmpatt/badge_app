class Badge
  include MongoMapper::Document

  key :title, String, :length => { :maximum => 25 }
  key :description, String, :length => { :maximum => 140 }, :default => ""
  key :tags, Array
  timestamps!
   
  # Relationships.
  many :users
  
  #validations
  validates_presence_of :title
  validates_uniqueness_of :title

end
