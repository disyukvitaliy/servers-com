require_relative 'initializer'

use Rack::ContentType, 'application/json'
use Rack::CommonLogger

app = Rack::URLMap.new(
  '/trackers' => TrackersController.new,
  '/tracker_statistics' => TrackerStatisticsController.new
)

protected_app = Rack::Auth::Basic.new(app, 'main') do |username, password|
  Rack::Utils.secure_compare('admin', username) &&
    Rack::Utils.secure_compare('secret', password)
end

run protected_app # kinda ¯\_(ツ)_/¯

