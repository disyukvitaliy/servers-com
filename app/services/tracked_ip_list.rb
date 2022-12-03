require 'singleton'

class TrackedIpList
  include Singleton

  KEY = 'tracked_ips'

  def all
    $redis.smembers(KEY)
  end

  def save(ip)
    $redis.sadd(KEY, ip)
  end

  def delete(ip)
    $redis.srem(KEY, ip)
  end
end