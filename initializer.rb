require 'yaml'
require 'redis'
require 'sequel'

$redis = Redis.new(
  YAML.load(File.read('config/redis.yml'))[ENV['APP_ENV'] || 'development']
)

$db = Sequel.connect(
  YAML.load(File.read('config/database.yml'))[ENV['APP_ENV'] || 'development']
)

Dir[File.join(__dir__, 'app', '**', '*.rb')].each do |path|
  autoload(
    path.sub('.rb', '').split('/').last.split('_').collect!(&:capitalize!).join,
    path
  )
end
