class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html

  # NotFound errors will be redirected to the action not_found while any other will be redirected to the action generic.
  rescue_from ApiClient::Exceptions::Unauthorized, :with => :unauthorized_access
  rescue_from ApiClient::Exceptions::NotFound, :with => :not_found
  rescue_from ApiClient::Exceptions::Generic, :with => :generic

  # This code is only for example purposes.
  # Any behavior can be executed here. Just write your own.
  def unauthorized_access
    redirect_to "http://www.example.com/sign_in?redirect_uri=#{request.url}"
  end

  def not_found
    ApplicationMailer.send_not_found_notice.deliver
    render :file => "/public/404.html", :status => 404
  end

  def generic(exception)
    ApplicationMailer.send_generic_error(exception).deliver
    render :file => "/public/404.html", :status => 404
  end
end
