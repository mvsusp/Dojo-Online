require 'spec_helper'

describe UserController do

integrate_views

  after(:each) do
    cookies[:user] = nil;
  end
  
  it "should redirect to login on invalid action when not logged in" do
    cookies[:user] = nil;
    get 'user/blah'
    response.should redirect_to(:controller => 'login', :action => 'index')
  end
  
  it "should redirect to welcome on invalid action when logged in" do
    cookies[:user] = "test";
    get 'user/blah'
    response.should redirect_to(:controller => 'login', :action => 'welcome')
  end

end
