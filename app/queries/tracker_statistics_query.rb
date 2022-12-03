class TrackerStatisticsQuery < Struct.new(:params)
  def call
    Ping.where(ip: params['ip'], created_at: params['start']..params['end']).select(
      Sequel.function(:min, :delay).as(:delay_min),
      Sequel.function(:max, :delay).as(:delay_max),
      Sequel.cast_numeric(Sequel.function(:avg, :delay)).as(:delay_avg),
      Sequel.function(:count).*.filter(delay: nil).as(:attempts_failed),
      Sequel.function(:count).*.as(:attempts_total)
    ).first
  end
end