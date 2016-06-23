module Bitovi
  class Config
    attr_accessor :redis_host, :redis_port, :redis_db, :fetch_url

    def initialize(redis_host = '127.0.0.1', redis_port = 6379, redis_db = 1, 
          fetch_url = 'http://stream.meetup.com/2/open_events?')

      @redis_host, @redis_port, @redis_db = redis_host, redis_port, redis_db
      @fetch_url = fetch_url

    end

  end
end