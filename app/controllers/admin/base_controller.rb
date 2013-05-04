class Admin::BaseController < ApplicationController
  before_filter :authenticate
  before_filter :namespace_view_path

  private

  def authenticate
    raise AccessDenied unless current_user
  end

  # Allow namespaced template inheritance in application directory
  def namespace_view_path
    prepend_view_path 'app/views/admin'
  end
end
