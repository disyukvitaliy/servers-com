require 'redis'

$redis = Redis.new

Dir[File.join(__dir__, 'app', '**', '*.rb')].each { |file| require file }