The purpose of this take-home interview is to provide us with practical insight into how you 
think about and solve problems. The structure of your solution should reflect this. A good 
submission will be succinct, while still being readable. It will show your work. Your 
comments should reflect the "whys" of your approach, not the "whats".

The solution to this take-home interview should be written in Ruby and submitted in an email 
that includes a URL to a Github (or related site, such as Bitbucket or Gitlab) repository.

The requirements for the take-home interview are as follows:
* Connect to the Meetup streaming HTTP API[1] and listen for new Meetup events coming in over 
the HTTP stream.
* Parse the received event(s), plucking the name/title of the event.
* Push the object containing the event's name and title onto a Redis list[2].
* Keep the stream open indefinitely. (i.e. no polling, and should reconnect to the service 
if the connection is killed by a third party)
* Follow the recommendations provided by the Meetup open_events API (e.g. make use of the 'since_mtime' 
query parameter).

[1] - http://www.meetup.com/meetup_api/docs/stream/2/open_events/
[2] - http://redis.io/topics/data-types
