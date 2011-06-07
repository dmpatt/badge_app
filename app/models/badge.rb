class Badge
  include MongoMapper::Document
  
  attr_accessor :tag

  key :title, String, :length => { :maximum => 25 }
  key :description, String, :length => { :maximum => 140 }, :default => ""
  key :tags, Array
  timestamps!
   
  # Relationships.
  many :users
  
  #validations
  validates_presence_of :title
  validates_uniqueness_of :title
  
  def add_tag(tag)
	if tag
		  self.tags << tag
		  self.save
	 end
  end	  
	  
end
