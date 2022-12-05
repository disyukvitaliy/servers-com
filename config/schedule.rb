# frozen_string_literal: true

require_relative '../initializer'

require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

Signal.trap('SIGINT') { scheduler.shutdown }

scheduler.every '1m', TrackerStatisticsCollector

scheduler.join
