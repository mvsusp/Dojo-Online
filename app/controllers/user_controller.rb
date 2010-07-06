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

    rooms = IsInTheRoom.find :all, :conditions => {:user_id => @user.id}
    rooms.each do |r|
        r.room.initiated = false if r.owner
        r.room.save
        r.delete
    end

    @user.delete
    redirect_to :controller => "login", :action => "index"
  end

end
