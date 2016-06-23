require "redis"

module Bitovi
  #Trying to separate the data access, encapsulation in a module 
  #will make it simpler to replace it in the future
  module DataAccessable
    @@redis = Redis.new(:host => @redis_host, :port => @redis_port, :db => @redis_db)

    def push_to_list(list, value)
      @@redis.lpush(list, value)
    end
    
    def self.redis
      @@redis
    end

    def self.init(redis_host, redis_port, redis_db)
      @@redis_host = redis_host
      @@redis_port = redis_port
      @@redis_db = redis_db
    end
  end
end