class Rack::Attack
  ### Configure Cache ###

  # If you don"t want to use Rails.cache (Rack::Attack"s default), then
  # configure it here.
  #
  # Note: The store is only used for throttling (not blacklisting and
  # whitelisting). It must implement .increment and .write like
  # ActiveSupport::Cache::Store

  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  ### Throttle Spammy Clients ###

  # If any single client IP is making tons of requests, then they"re
  # probably malicious or a poorly-configured scraper. Either way, they
  # don"t deserve to hog all of the app server"s CPU. Cut them off!
  #
  # Note: If you"re serving assets through rack, those requests may be
  # counted by rack-attack and this throttle may be activated too
  # quickly. If so, enable the condition to exclude them from tracking.

  # Throttle all requests by IP
  #
  # Key: "rack::attack:#{Time.now.to_i/:period}:req/ip:#{req.ip}"
  throttle("req/ip", limit: 20, period: 10.seconds) do |request|
    request.ip if request.path != "/api-docs"
  end

  ### Custom Throttle Response ###

  # By default, Rack::Attack returns an HTTP 429 for throttled responses,
  # which is just fine.
  #
  # If you want to return 503 so that the attacker might be fooled into
  # believing that they"ve successfully broken your app (or you just want to
  # customize the response), then uncomment these lines.
  self.throttled_response = lambda do |env|
    now = Time.now.utc
    match_data = env["rack.attack.match_data"]

    headers = {
      "Content-Type": "application/json",
      "X-RateLimit-Limit": match_data[:limit].to_s,
      "X-RateLimit-Remaining": "0",
      "X-RateLimit-Reset": (now + (match_data[:period] - now.to_i % match_data[:period])).to_s
    }

    [
      429,
      headers,
      [{ error: "Take it easy, we only allow 60rpm." }.to_json]
    ]
  end

  # what's the ip when the app is behing a load balancer

  class Request < ::Rack::Request
    def remote_ip
      @remote_ip ||= (env["action_dispatch.remote_ip"] || ip).to_s
    end
  end
end
