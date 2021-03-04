# frozen_string_literal: true

class PingbackRack
  PINGBACK_REGEX = /^\/xmlrpc/

  def initialize(app)
    @app = app
  end

  def call(env)
    req = ::Rack::Request.new(env)

    if PINGBACK_REGEX.match(req.path_info)
      process_request(env)
    else
      @app.call(env)
    end
  end

  def process_request(env)
    Pingback::Server.new(Proc.new { |source_uri, target_uri|
      raise GenericFaultException unless Linkback.find_or_create_by(source_uri: source_uri, target_uri: target_uri)
    }).call(env)

  rescue StandardError => e
    [403, {'Content-Type' => 'text/plain'}, [e.message]]
  end
end
