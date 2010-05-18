class UserController < ApplicationController

  def create
    @user = User.new(params[:user])
    if (@user.save) 
      cookies[:user] = @user.name
      # redirect_to :controller => "dojo", :action => "list"
      redirect_to :controller => "rooms", :action => "index"
    else
      flash[:user] = "Error: username taken or invalid"
      redirect_to :controller => "login", :action => "index"
    end
  end

  def remove
    name = cookies[:user]
    cookies.delete :user
    @user = User.find(:first, :conditions => {:name => name})
    @user.delete
    redirect_to :controller => "login", :action => "index"
  end
end
