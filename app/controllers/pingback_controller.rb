class PingbackController < ApplicationController

  def xmlrpc
    @pingback = Pingback::Server.new(Proc.new { |source_uri, target_uri|
      raise GenericFaultException unless Linkback.create(:source_uri => source_uri, :target_uri => target_uri)
    })
    response.content_type = "text/xml; charset=utf-8"
    render :text => @pingback.call(env)
  end

end
