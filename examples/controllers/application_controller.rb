class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html

  # NotFound errors will be redirected to the action not_found while any other will be redirected to the action generic.
  rescue_from ApiClient::Exceptions::NotFound, :with => :not_found
  rescue_from ApiClient::Exceptions::Generic, :with => :generic

  # This code is only for example purposes.
  # Any behavior can be executed here. Just write your own.
  def not_found
    ApplicationMailer.send_not_found_notice.deliver
  end

  def generic
    ApplicationMailer.send_generic_error.deliver
  end
end