$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/../')

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
    end

    def object_parsed(obj)
      @since_mtime = obj[:mtime]
      begin
        event = Event.new(obj[:name])
        event.save
      rescue Exception => e
        log_error(e.message)
      end
    end

    def get_events(since_mtime = nil)
      streamer = lambda do |chunk, remaining_bytes, total_bytes|
        begin
          @parser << chunk
        rescue Exception => e
          log_error(e.message)
        end
      end

      begin 
        query = @since_mtime ? {:since_mtime => @since_mtime} : []
        Excon.get(@fetch_url, :query => query, :response_block => streamer)
      rescue Excon::Errors::Timeout => ex
        log_error("Error fetching data #{ex.message}")
        return @since_mtime
      end
    end
  end
end