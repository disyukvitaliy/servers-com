require_relative 'config/application'

protected_app = Rack::Auth::Basic.new(App.instance, 'main') do |username, password|
  Rack::Utils.secure_compare('admin', username) &&
    Rack::Utils.secure_compare('secret', password)
end

run protected_app # kinda ¯\_(ツ)_/¯
