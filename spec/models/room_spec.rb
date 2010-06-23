require 'spec_helper'

describe Room do
  before(:each) do
    @lang = Language.create!(:name => "Ruby")
    @valid_attributes = {
      :name => "value for name",
      :description => "value for description",
      :languages => [Language.create(:name => 'Ruby')]
    }
  end


  it "User should be in the room" do
    @user = User.create!(:name => "test1")
    @room = Room.create!(:name => "test1",:description => "something",:languages   => [@lang])
    @room.initiated = true
    @room.add_user(@user, true)

    a = IsInTheRoom.find :all, :conditions => {:user_id => @user.id, :room_id => @room.id}
    a.should_not == nil

  end


  it "User should not enter in room again" do
    user = User.create!(:name => "test2")
    room = Room.create!(:name => "test2",:description => "something",:languages   => [@lang])
    room.initiated = true
    room.add_user(user, true)

    room.add_user(user, false)

    a = IsInTheRoom.find :all, :conditions => {:user_id => user.id, :room_id => room.id}
    a.length.should == 1
  end

  it "should create a new instance given valid attributes" do
    Room.create!(@valid_attributes)
  end

  it "should not allow two rooms with the same name" do
    @lang = [Language.create(:name => 'Ruby'), Language.create({:name => 'Java'})]
    Room.create({:name => "test",:description => "something",:languages => @lang})
    invalid_room = Room.create({:name => "test",:description => "something",:languages => @lang})
    invalid_room.should have(1).error_on(:name)
  end

  it "should not allow blank names" do
    @lang = [Language.create(:name => 'Ruby'), Language.create({:name => 'Java'})]
    invalid_room = Room.create({:name => "",:description => "something",:languages => @lang})
    invalid_room.should have(1).error_on(:name)
  end

  it "should not allow blank descriptions" do
    @lang = [Language.create(:name => 'Ruby'), Language.create({:name => 'Java'})]
    invalid_room = Room.create({:name=>'test',:description => "",:languages => @lang})
    invalid_room.should have(1).error_on(:description)
  end

  it "should not allow blank languages" do
    invalid_room = Room.create({:name=>'test',:description => "something"})
    invalid_room.should have(1).error_on(:languages)
  end

  it "should not allow blank language array" do
    invalid_room = Room.create({:name=>'test',:description => "something",:languages=>[]})
    invalid_room.should have(1).error_on(:languages)
  end

  it 'should include an owner to an existing room' do
    r = Room.create(@valid_attributes)
    r.add_user(User.create!(:name => 'assas'), true)
    owners = r.is_in_the_room.find :all, :conditions => {:owner => true}
    owners.size.should == 1
    owners[0].user.name.should == 'assas'
    owners[0].owner.should == true
  end 

  it 'should include an user to an existing room' do
    r = Room.create(@valid_attributes)
    r.add_user(User.create!(:name => 'assas'), false)
    owners = r.is_in_the_room.find :all, :conditions => {:owner => false}
    owners.size.should == 1
    owners[0].user.name.should == 'assas'
    owners[0].owner.should == false
  end 

end
