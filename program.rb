require File.dirname(__FILE__) + '/config'
require File.dirname(__FILE__) + '/services/meetup_service'
require File.dirname(__FILE__) + '/util/loggeable'

class Program
  config = Bitovi::Config.new

  Bitovi::DataAccessable.init(config.redis_host, config.redis_port, config.redis_db)

  @meetup_service = Bitovi::MeetupService.new(config.fetch_url)
  @since_mtime = nil
  loop do
    @since_mtime = @meetup_service.get_events(@since_mtime)
  end  
end