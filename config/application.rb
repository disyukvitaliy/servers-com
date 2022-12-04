require_relative '../initializer'
require 'forwardable'
require 'singleton'
require 'rack'

class App
  extend Forwardable
  include Singleton

  def_delegators :@app, :call

  def initialize
    @app = Rack::Builder.app do
      use Rack::ContentType, 'application/json'
      use Rack::CommonLogger

      run Rack::URLMap.new(
        '/trackers' => TrackersController.new,
        '/tracker_statistics' => TrackerStatisticsController.new
      )
    end
  end
end