require 'redis'
require 'sequel'

$redis = Redis.new
$db = Sequel.connect(
  adapter: 'postgres',
  host: 'localhost',
  database: 'postgres',
  user: 'postgres',
  password: 'postgres'
)

Dir[File.join(__dir__, 'app', '**', '*.rb')].each do |path|
  autoload(
    path.sub('.rb', '').split('/').last.split('_').collect!(&:capitalize!).join,
    path
  )
end
