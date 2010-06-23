require 'spec_helper'

describe 'User List get' do

  before :all do
    Room.destroy_all
    User.destroy_all
    Language.destroy_all
    @user = User.create(:name => 'unique')
    l = Language.create()
    @room = Room.create! :languages => [l], :description => 'a', :name => 'n'
  end

  # before :each do  
  #   UserList.destroy_all
  # end
  # 
  it 'should return a list with no users' do
    cookies[:user] = 'User'
    get '/userlist', :room => @room.id
    response.body.should == '[]'
  end
  
  it 'should list users in the room' do
    cookies[:user] = 'User'
    @room.add_user(@user, true)
    get '/userlist', :room => @room.id
    response.body.should == ['unique'].to_json
  end
  
  it 'should return \'Not logged in\' when not logged in' do
    get '/userlist', :room => @room.id
    response.status.should == '400'
    response.body.should == 'Not logged in'
  end
  
  it 'should return \'Room not found\' with invalid room' do
    cookies[:user] = 'User'
    get '/userlist', :room => -1
    response.status.should == '400'
    response.body.should == 'Room not found'
  end
  
end
