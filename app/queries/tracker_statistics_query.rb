# frozen_string_literal: true

TrackerStatisticsQuery = Struct.new(:params) do
  def call # rubocop:disable Metrics/AbcSize
    Ping.where(ip: params['ip'], created_at: params['start']..params['end']).select(
      Sequel.function(:min, :delay).as(:delay_min),
      Sequel.function(:max, :delay).as(:delay_max),
      Sequel.cast_numeric(Sequel.function(:avg, :delay)).as(:delay_avg),
      Sequel.cast_numeric(Sequel.function(:percentile_cont, 0.5).within_group(:delay)).as(:delay_med),
      Sequel.function(:count).*.filter(delay: nil).as(:attempts_failed),
      Sequel.function(:count).*.as(:attempts_total)
    ).first
  end
end
