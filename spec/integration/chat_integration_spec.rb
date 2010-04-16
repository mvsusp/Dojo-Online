require 'spec_helper'

describe 'Chat Messages post' do

  it 'should create a new ChatMessage' do
    cookies[:user] = "Batman"
    post "/chat", :message => "test1"
    response.should be_success
    chats = ChatMessage.find(:first, :conditions => {:message => "test1", :poster => "Batman"}) 
    chats[:poster].should == "Batman"    
    chats[:message].should == "test1"    
  end
 
  it 'should NOT create a new ChatMessage when not logged in' do
    cookies[:user] = nil
    post "/chat", :message => "test36"
    response.should be_success
    chats = ChatMessage.find(:first, :conditions => {:message => "test36"}) 
    chats.should == nil; 
  end

end

describe 'Chat message list' do

  it 'should return a valid json' do
    get "/chat"
    response.should be_success
    response.body.should == "[]"
  end
  
  it 'should return all posts' do
    cookies[:user] = "Batman"
    post "/chat", :message => "test_01"
    cookies[:user] = "Robin"
    post "/chat", :message => "test_02"
    get "/chat"
    response.should be_success
    response.body.should == "[{user_name: \"Batman\", message: \"test_01\"},{user_name: \"Robin\", message: \"test_02\"}]"
  end

end
