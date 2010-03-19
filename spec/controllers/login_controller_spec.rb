require 'spec_helper'

describe LoginController do

  #Delete these examples and add some real ones
  it "should use LoginController" do
    controller.should be_an_instance_of(LoginController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end
end
