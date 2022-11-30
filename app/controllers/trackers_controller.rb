require_relative 'base_controller'
require 'dry-schema'

class TrackersController < BaseController
  def handle(request)
    if request.get?
      index
    elsif request.post?
      create(request.params)
    elsif request.delete?
      delete(request.params)
    else
      head(404)
    end
  end

  private

  def index
    reply(trackers: TrackedIPList.instance.all.map { |ip| { ip: ip } })
  end

  def create(params)
    schema_check = schema.call(params)

    if schema_check.success?
      TrackedIPList.instance.save(params['ip'])
      head(204)
    else
      reply_with_errors(schema_check)
    end
  end

  def delete(params)
    schema_check = schema.call(params)

    if schema_check.success?
      TrackedIPList.instance.delete(params['ip'])
      head(204)
    else
      reply_with_errors(schema_check)
    end
  end

  def reply_with_errors(schema_check)
    reply({ errors: schema_check.errors.to_hash }, 422)
  end

  def schema
    Dry::Schema.Params do
      required(:ip).filled(:string, format?: IP_REGEX)
    end
  end
end