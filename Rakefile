# frozen_string_literal: true

namespace :db do
  desc 'Run migrations'
  task :migrate, [:version] do |_t, args|
    require_relative 'initializer'
    require 'sequel/core'
    Sequel.extension :migration
    version = args[:version].to_i if args[:version]
    Sequel::Migrator.run($db, 'migrations', target: version)
  end
end

namespace :test do
  desc 'Run tests'
  task :run do
    ENV['APP_ENV'] = 'test'
    require 'minitest/autorun'
    require_relative 'config/application'
    Dir[File.join(__dir__, 'test', '**', '*_test.rb')].each { |path| require path }
  end
end
