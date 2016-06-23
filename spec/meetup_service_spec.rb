require 'rspec'
require 'excon'
require File.dirname(__FILE__) + '/helper'
require File.dirname(__FILE__) + '/helpers/data_helper'
require File.dirname(__FILE__) + '/../config'
require File.dirname(__FILE__) + '/../models/event'
require File.dirname(__FILE__) + '/../services/meetup_service'
require File.dirname(__FILE__) + '/../util/loggeable'

describe "meetup service" do
  before(:all) do
    @config = Bitovi::Config.new
    Bitovi::DataAccessable.init(@config.redis_host, @config.redis_port, 22)
    Bitovi::DataAccessable.redis.flushdb
    Excon.defaults[:mock] = true
    Excon.stub({}, :body => DataHelper.meetup_json_mock, :headers => DataHelper.headers, :status => 200)
    @meetup_service = Bitovi::MeetupService.new(@config.fetch_url)
  end

  it "connect to the api and save the data" do
    @meetup_service.get_events
    
    name1 = "Trust Deeds and TurnKEY [FLIPS]"
    name2 = "Overnight, Outdoor Adventure and Hotspring Extravaganza!"
    name3 = "The Founding Mums' Exchange: London"
    
    data1 = Bitovi::DataAccessable.redis.lpop('Bitovi::Events')
    data2 = Bitovi::DataAccessable.redis.lpop('Bitovi::Events')
    data3 = Bitovi::DataAccessable.redis.lpop('Bitovi::Events')
    
    expect(data1).to eq(name1)
    expect(data2).to eq(name2)
    expect(data3).to eq(name3)
  end
end
