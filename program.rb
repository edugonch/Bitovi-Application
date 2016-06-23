require File.dirname(__FILE__) + '/config'
require File.dirname(__FILE__) + '/services/meetup_service'
require File.dirname(__FILE__) + '/util/loggeable'

class Program
  config = Bitovi::Config.new

  Bitovi::DataAccessable.init(config.redis_host, config.redis_port, config.redis_db)

  @meetup_service = Bitovi::MeetupService.new(config.fetch_url)
  
  #The application loop on the get_events
  #If the connection is lost, the application will try again
  loop do
    begin
      @meetup_service.get_events
    rescue
    end
  end  
end