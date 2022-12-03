require_relative 'initializer'

namespace :db do
  desc 'Run migrations'
  task :migrate, [:version] do |t, args|
    require 'sequel/core'
    Sequel.extension :migration
    version = args[:version].to_i if args[:version]
    Sequel::Migrator.run($db, 'migrations', target: version)
  end
end