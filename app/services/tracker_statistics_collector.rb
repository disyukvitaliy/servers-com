require 'net/ping/icmp'

class TrackerStatisticsCollector
  IPS_PER_THREAD = 20
  MAX_THREADS = 50

  def call
    jobs = Queue.new(TrackedIpList.instance.all)

    threads = [jobs.length / IPS_PER_THREAD, MAX_THREADS].min

    p "Statistics collecting has been started; IPs count: #{jobs.length}; Threads count: #{threads}"

    workers = threads.times.map do
      Thread.new do
        statistics = []
        icmp = Net::Ping::ICMP.new(nil, 7)
        while ip = jobs.pop(true)
          delay = icmp.ping(ip)
          statistics.push([
            ip,
            delay ? delay * 1000 : nil,
            Time.now
          ])
        end
      rescue ThreadError
        Ping.import([:ip, :delay, :created_at], statistics)
      end
    end

    workers.map(&:join)
  end
end