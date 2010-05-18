require 'spec_helper'

describe 'Chat Messages post' do

  before :all do
    Room.destroy_all
    User.destroy_all
    Language.destroy_all
    user = User.create(:name => 'unique')
    l = Language.create()
    @room = Room.create! :languages => [l], :description => 'a', :user => user, :name => 'n'
    @room2 = Room.create!  :languages => [l], :description => 'a', :user => user, :name => 'nqwe'
  end

  before :each do  
    c = ChatMessage.destroy_all
  end

  it 'should create a new ChatMessage' do
    cookies[:user] = "User1"
    post '/chat', :message => "test1", :room => @room.id
    response.should be_success
    chats = ChatMessage.find(:first, :conditions => {:message => "test1", :poster => "User1"}) 
    chats[:poster].should == "User1"    
    chats[:message].should == "test1"
    chats[:room_id].should == @room.id
  end
 
  it 'should NOT create a new ChatMessage when not logged in' do
    cookies[:user] = nil
    post "/chat", :message => "test36", :room => @room.id
    response.status.should == '400'
    response.body.should == 'Not logged in'
    chats = ChatMessage.find(:first, :conditions => {:message => "test36"}) 
    chats.should == nil; 
  end

  it 'should not create a new ChatMessage without a Room' do
    cookies[:user] = 'User'
    post '/chat', :message => 'm'
    response.status.should == '400'
    response.body.should == 'No room received'
    chat = ChatMessage.find :first, :conditions => {:message => "m"}
    chat.should be_nil
  end

  it 'should not create a new ChatMessage with non-existent Room' do
    cookies[:user] = 'User'
    post '/chat', :message => 'm', :room => -1
    response.status.should == '400'
    response.body.should == 'Room not found'
    chat = ChatMessage.find :first, :conditions => {:message => "m"}
    chat.should be_nil
  end
  
  it 'should not create an empty ChatMessage' do
    cookies[:user] = "User"
    post '/chat', :message => "", :room => @room.id
    response.status.should == '400'
    response.body.should == 'Empty message'
    chat = ChatMessage.find :first, :conditions => {:poster => "User"}
    chat.should be_nil
  end

  it 'should post each message only in its own room' do
    cookies[:user] = "User"
    post "/chat", :message => "test1", :room => @room.id
    response.should be_success
    post "/chat", :message => "test2", :room => @room2.id
    response.should be_success
    chat1 = ChatMessage.find :first, :conditions => {:poster => "User", :message => "test1", :room_id => @room.id}
    chat2 = ChatMessage.find :first, :conditions => {:poster => "User", :message => "test2", :room_id => @room2.id}
    chat3 = ChatMessage.find :first, :conditions => {:poster => "User", :message => "test2", :room_id => @room.id}
    chat4 = ChatMessage.find :first, :conditions => {:poster => "User", :message => "test1", :room_id => @room2.id}
    chat1.should_not be_nil
    chat2.should_not be_nil
    chat3.should be_nil
    chat4.should be_nil
  end
  
  it 'should receive a lot of chat with no problem' do
    cookies[:user] = 'User'
    for i in 1 .. 250 do
      post '/chat', :message => 'test' + i.to_s, :room => @room.id
    end
    chats = ChatMessage.find :all, :conditions => {:poster => 'User', :room_id => @room.id}
    chats.size.should == 250
  end
  
end

