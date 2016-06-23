require 'rspec'
require File.dirname(__FILE__) + '/helper'
require File.dirname(__FILE__) + '/../config'
require File.dirname(__FILE__) + '/../models/event'
require File.dirname(__FILE__) + '/../util/loggeable'

describe "save event" do
  before(:all) do
    @config = Bitovi::Config.new
    Bitovi::DataAccessable.init(@config.redis_host, @config.redis_port, 22)
    Bitovi::DataAccessable.redis.flushdb
  end

  it "should save the event on the redis list" do
    name = "Test Event"
    event = Bitovi::Event.new(name)
    event.save
    data = Bitovi::DataAccessable.redis.lpop('Bitovi::Events')
    
    expect(data).to eq(name)
  end
end

