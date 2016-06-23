require File.dirname(__FILE__) + '/../models/event'

require 'rubygems'
require 'excon'
require 'yajl/yajl'

module Bitovi
  class MeetupService

    def initialize(fetch_url)
      @fetch_url = fetch_url
      @parser = Yajl::Parser.new(:symbolize_keys => true)
      @parser.on_parse_complete = method(:object_parsed)
      @since_mtime = nil
      @connection = Excon.new(@fetch_url, :persistent => true)
    end

    def object_parsed(obj)
      @since_mtime = obj[:mtime]
      event = Event.new(obj[:name])
      event.save
    end

    def get_events
      streamer = lambda do |chunk, remaining_bytes, total_bytes|
        begin
          @parser << chunk
        rescue Exception => e
          log_error(e.message)
        end
      end

      begin 
        query = @since_mtime ? {:since_mtime => @since_mtime} : []
        @connection.get(:query => query, :response_block => streamer)
      rescue Excon::Errors::Timeout => ex
        log_error("Error fetching data #{ex.message}")
        @connection.reset
      end
    end
  end
end