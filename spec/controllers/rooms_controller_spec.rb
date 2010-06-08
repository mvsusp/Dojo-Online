require 'spec_helper'

describe RoomsController do

  before do
    Room.destroy_all
    @lang = [Language.create(:name => 'Ruby'), Language.create({:name => 'Java'})]
    cookies[:user] = "Batman"
  end

  after do
    cookies[:user] = ""
  end

  it "should not list uninitiated rooms" do
    Room.create({:name => "test1",:description => "something",:languages => @lang,
       :user=>User.create(:name=>'foo1')})

    Room.create({:name => "test1",:description => "something",:languages => @lang,
       :user=>User.create(:name=>'foo2')})

    assert_response :success
    get :index

    assigns[:rooms].should == []
  end


  it "should list initiated rooms" do
    room1 = Room.create({:name => "test1",:description => "something",:languages => @lang,
      :user=>User.create(:name=>'foo1'), :initiated=>true})

    room2 = Room.create({:name => "test2",:description => "something",:languages => @lang,
    :user=>User.create(:name=>'foo2'),:initiated=>true})
    
    rooms = [room1, room2]

    assert_response :success
    get :index

    assigns[:rooms].should == rooms

  end

end

