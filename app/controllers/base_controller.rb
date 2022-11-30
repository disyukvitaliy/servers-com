require 'json'

class BaseController
  IP_REGEX = /^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$/

  def call(env)
    handle(Rack::Request.new(env))
  end

  private

  def head(status)
    reply(nil, status)
  end

  def reply(body, status = 200, headers = {})
    Rack::Response.new(
      body.instance_of?(Hash) ? body.to_json : body,
      status,
      headers
    ).finish
  end
end