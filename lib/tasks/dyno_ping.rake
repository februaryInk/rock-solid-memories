desc 'Send a GET request to the server to keep the Heroku dyno from sleeping.'
task :dyno_ping do
        
  require 'net/http'
  
  if ENV[ 'PING_URL' ]
    
    puts 'Pinging...'
    
    uri = URI( ENV[ 'PING_URL' ] )
    Net::HTTP.get_response( uri )
  end
end
