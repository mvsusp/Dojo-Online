require 'spec_helper'

describe LoginController do

  it "should redirect to login on invalid controller" do
    get 'blah'
    response.should redirect_to(:controller => 'login', :action => 'index')
  end


  
end
