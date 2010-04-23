require 'spec_helper'

describe 'Chat Messages post' do

  before :all do
    @room = Room.create
    @room2 = Room.create
  end

  it 'should create a new ChatMessage' do
    cookies[:user] = "Batman"
    post '/chat', :message => "test1", :room => 1
    response.should be_success
    chats = ChatMessage.find(:first, :conditions => {:message => "test1", :poster => "Batman"}) 
    chats[:poster].should == "Batman"    
    chats[:message].should == "test1"    
  end
 
  it 'should NOT create a new ChatMessage when not logged in' do
    cookies[:user] = nil
    post "/chat", :message => "test36", :room => 1
    response.status.should == '400'
    chats = ChatMessage.find(:first, :conditions => {:message => "test36"}) 
    chats.should == nil; 
  end

  it 'should not create a new ChatMessage without a Room' do
    cookies[:user] = 'User'
    post '/chat', :message => 'm'
    response.status.should == '400'
    chat = ChatMessage.find :first, :conditions => {:message => "m"}
    chat.should be_nil
  end

  it 'should not create an empty ChatMessage' do
    cookies[:user] = "User"
    post '/chat', :message => "", :room => 1
    response.status.should == '400'
    chat = ChatMessage.find :first, :conditions => {:poster => "User"}
    chat.should be_nil
  end

  it 'should post each message only in its own room' do
    cookies[:user] = "User"
    post "/chat", :message => "test1", :room => 1
    response.should be_success
    post "/chat", :message => "test2", :room => 2
    response.should be_success
    chat1 = @room.chat_messages.find :first, :conditions => {:poster => "User", :message => "test1"}
    chat2 = @room2.chat_messages.find :first, :conditions => {:poster => "User", :message => "test2"}
    chat3 = @room.chat_messages.find :first, :conditions => {:poster => "User", :message => "test2"}
    chat4 = @room2.chat_messages.find :first, :conditions => {:poster => "User", :message => "test1"}
    chat1.should != nil
    chat2.should != nil
    chat3.should be_nil
    chat4.should be_nil
  end
end

describe 'Chat message list' do

  before :all do
    @room = Room.new
    @room.save
    @room2 = Room.new
    @room2.save
  end


  it 'should return a valid json' do
    cookies['user'] = "User"
    get "/chat", :room => 1
    response.should be_success
    response.body.should == "[]"
  end
  
  it 'should return all posts' do
    cookies[:user] = "Batman"
    post "/chat", :message => "test_01", :room => 1
    cookies[:user] = "Robin"
    post "/chat", :message => "test_02", :room => 1
    get "/chat", :room => 1
    response.should be_success
    messages = [{:poster => "Batman", :message => "test_01"},{:poster => "Robin", :message =>"test_02"}]
    response.body.should == messages.to_json
  end

  it 'should get messages from two different rooms' do
    cookies[:user] = "User"
    post "/chat", :message => "test1", :room => 1
    post "/chat", :message => "test2", :room => 2
    get '/chat', :room => 1
    response.should be_success
    room1_messages_json = response.body
    get '/chat', :room => 2
    response.should be_success
    room2_messages_json = response.body
    room1_messages_json.should == [{:poster => 'User', :message => 'test1'}].to_json
    room2_messages_json.should == [{:poster => 'User', :message => 'test2'}].to_json
  end

  it 'should return empty if it does not receive a room' do
    get '/chat'
    response.body.should be_empty
  end

end
