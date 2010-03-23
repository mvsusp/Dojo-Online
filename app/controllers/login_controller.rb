class LoginController < ApplicationController

  def index
    if cookies[:user] 
      redirect_to :action => "welcome"
    end
  end

  def welcome
    if not cookies[:user]  
      flash[:user] = "Você precisa fazer o login!"
      redirect_to :action => "index"
    end
  end

  def logout
    redirect_to :controller => "user", :action => "remove"
  end
end
