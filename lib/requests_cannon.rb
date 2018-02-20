require "http_client.rb"

###
# Usage example:
# Open rails console
#  - require "./lib/requests_cannon.rb"
#  - RequestsCannon.fire(<number_of_requests>)
# If you pass the limit you should see responses like:
# {
#   status: #<Net::HTTPTooManyRequests:0x007ff91e0fb6e8>,
#   body: {"error":"Take it easy, we only allow 60rpm."}
# }
###

class RequestsCannon
  URL = "http://localhost:3000".freeze
  ROUNDS = 60

  def self.fire(url = URL, rounds = ROUNDS)
    threads = []
    rounds.times do |round|
      threads << Thread.new { shoot(url, round, method(:fire_callback)) }
    end
    threads.each(&:join)
    "All #{rounds} fired."
  end

  private_class_method

  def self.shoot(url, round, callback)
    callback.call(HttpClient.get(url), round)
  end

  def self.fire_callback(response, _round)
    puts "{ status: #{response}, body: #{response.body} }"
  end
end
