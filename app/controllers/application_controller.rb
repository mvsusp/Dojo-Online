# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :verify_login, :except => ['index', 'create'] 
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
 
  def verify_login
    if (not cookies[:user]) 
      redirect_to :controller => 'login'
    end
  end
  
  def rescue_action(e)
    if not cookies[:user]
       redirect_to :controller => 'login', :action => 'index'
     else
       redirect_to :controller => 'login', :action => 'welcome'
     end
   end


  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
