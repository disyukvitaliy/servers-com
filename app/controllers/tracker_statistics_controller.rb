# frozen_string_literal: true

require_relative 'base_controller'
require 'dry-schema'

class TrackerStatisticsController < BaseController
  def handle(request)
    return head(404) unless request.get?

    schema_check = schema.call(request.params)

    if schema_check.success?
      reply(statistics: TrackerStatisticsQuery.new(request.params).call.to_hash)
    else
      reply({ errors: schema_check.errors.to_hash }, 422)
    end
  end

  private

  def schema
    Dry::Schema.Params do
      required(:ip).filled(:string, format?: IP_REGEX)
      required(:start).filled(:string)
      required(:end).filled(:string)
    end
  end
end
