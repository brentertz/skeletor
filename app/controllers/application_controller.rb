class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  class AccessDenied < ::StandardError; end

  rescue_from AccessDenied do |exception|
    redirect_to root_path, alert: 'Access Denied!'
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render file: 'public/404', formats: [:html], layout: false, status: 404 and return
  end

  private

  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end
end
