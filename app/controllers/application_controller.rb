class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  include Authable
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :permission_denied

private

  def permission_denied
    head 403
  end
end
