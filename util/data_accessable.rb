require "redis"

module Bitovi
  module DataAccessable
    @@redis = Redis.new(:host => @redis_host, :port => @redis_port, :db => @redis_db)

    def push_to_list(list, value)
      @@redis.lpush(list, value)
    end

    def self.init(redis_host, redis_port, redis_db)
      @@redis_host = redis_host
      @@redis_port = redis_port
      @@redis_db = redis_db
    end
  end
end