class RecentMessage
	KEY = "recent_messages" # redis key
	STORE_LIMIT = 5 	    #  the number of messages that should be kept

	def self.list(limit = STORE_LIMIT)
		$redis.lrange(KEY, 0, limit-1).map do |raw_messages|
			JSON.parse(raw_messages).with_indifferent_access
		end
	end 

	def self.push(raw_message)
		$redis.lpush(KEY, raw_message)
		$redis.ltrim(KEY, 0, STORE_LIMIT-1)
	end
end 