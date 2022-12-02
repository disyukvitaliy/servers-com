require 'redis'
require 'sequel/core'
require 'sequel/model'

$redis = Redis.new
$db = Sequel.connect(
  adapter: 'postgres',
  host: 'localhost',
  database: 'postgres',
  user: 'postgres',
  password: 'postgres'
)

Dir[File.join(__dir__, 'app', '**', '*.rb')].each { |file| require file }