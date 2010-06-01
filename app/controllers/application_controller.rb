# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  rescue_from ActionController::RoutingError, :with => :route_not_found
  before_filter :verify_login, :except => ['create'] 
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
 
  def verify_login
    return if self.controller_name == 'login' and (self.action_name == 'index')
    if (not cookies[:user]) 
      redirect_to :controller => 'login'
    end
  end
  

  def rescue_action(e)
    redirect_to :controller => 'login', :action => 'index' unless cookies[:user]
    redirect_to :controller => 'login', :action => 'welcome' if e.is_a? ActionController::UnknownAction
  end

  protected

  def route_not_found
    redirect_to :controller => 'login', :action => 'index'
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
