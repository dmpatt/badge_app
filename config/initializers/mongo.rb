MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "badges_app-#{Rails.env}"

if defined?(PhusionPassenger)
	PhusionPassenger.on_event(:starting_worker_process) do |forked|
		MongoMapper.connection.connect if forked
	end
end	

#ensure indexes

User.ensure_index([[:name, 1]])
User.ensure_index([[:email, 1]], :unique => true)
Admin.ensure_index([[:name, 1]])
Admin.ensure_index([[:email, 1]], :unique => true)
