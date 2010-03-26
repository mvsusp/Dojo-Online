class UserController < ApplicationController

  def create
    @user = User.new(params[:user])
    if (@user.save) 
      cookies[:user] = @user.name
      # redirect_to :controller => "dojo", :action => "list"
      redirect_to :controller => "login", :action => "welcome"
    else
      flash[:user] = "Erro - nome inválido ou em uso"
      redirect_to :controller => "login", :action => "index"
    end
  end

  def remove
    @user = User.find(:first, :conditions => {:name => cookies[:user]})
    @user.delete
    cookies.delete :user
    redirect_to :controller => "login", :action => "index"
  end
end
