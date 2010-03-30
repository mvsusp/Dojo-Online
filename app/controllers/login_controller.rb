class LoginController < ApplicationController

  def index
    if cookies[:user] 
      redirect_to :action => "welcome"
    end
  end

  def welcome

  end

  def logout
    redirect_to :controller => "user", :action => "remove"
  end
end
