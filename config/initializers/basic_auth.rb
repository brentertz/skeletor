# Protect site with basic authentication if ENV values are set
if ENV['basic_auth'] && ENV['basic_auth'] != 'false'
  Rails.application.config.middleware.insert_after(::Rack::Lock, '::Rack::Auth::Basic', ENV['site_name']) do |username, password|
    username == ENV['basic_auth_user'] && password == ENV['basic_auth_password']
  end
end
