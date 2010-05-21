require 'spec_helper'

describe RoomsController do

  before do
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

=begin
  describe "GET index" do
    it "assigns all rooms as @rooms" do
      Room.stub(:find).with(:all).and_return([mock_room])
      get :index
      assigns[:rooms].should == [mock_room]
    end
  end

  describe "GET show" do
    it "assigns the requested room as @room" do
      Room.stub(:find).with("37").and_return(mock_room)
      get :show, :id => "37"
      assigns[:room].should equal(mock_room)
    end
  end

  describe "GET new" do
    it "assigns a new room as @room" do
      Room.stub(:new).and_return(mock_room)
      get :new
      assigns[:room].should equal(mock_room)
    end
  end

  describe "GET edit" do
    it "assigns the requested room as @room" do
      Room.stub(:find).with("37").and_return(mock_room)
      get :edit, :id => "37"
      assigns[:room].should equal(mock_room)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created room as @room" do
        Room.stub(:new).with({'these' => 'params'}).and_return(mock_room(:save => true))
        post :create, :room => {:these => 'params'}
        assigns[:room].should equal(mock_room)
      end

      it "redirects to the created room" do
        Room.stub(:new).and_return(mock_room(:save => true))
        post :create, :room => {}
        response.should redirect_to(room_url(mock_room))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved room as @room" do
        Room.stub(:new).with({'these' => 'params'}).and_return(mock_room(:save => false))
        post :create, :room => {:these => 'params'}
        assigns[:room].should equal(mock_room)
      end

      it "re-renders the 'new' template" do
        Room.stub(:new).and_return(mock_room(:save => false))
        post :create, :room => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested room" do
        Room.should_receive(:find).with("37").and_return(mock_room)
        mock_room.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :room => {:these => 'params'}
      end

      it "assigns the requested room as @room" do
        Room.stub(:find).and_return(mock_room(:update_attributes => true))
        put :update, :id => "1"
        assigns[:room].should equal(mock_room)
      end

      it "redirects to the room" do
        Room.stub(:find).and_return(mock_room(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(room_url(mock_room))
      end
    end

    describe "with invalid params" do
      it "updates the requested room" do
        Room.should_receive(:find).with("37").and_return(mock_room)
        mock_room.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :room => {:these => 'params'}
      end

      it "assigns the room as @room" do
        Room.stub(:find).and_return(mock_room(:update_attributes => false))
        put :update, :id => "1"
        assigns[:room].should equal(mock_room)
      end

      it "re-renders the 'edit' template" do
        Room.stub(:find).and_return(mock_room(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested room" do
      Room.should_receive(:find).with("37").and_return(mock_room)
      mock_room.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the rooms list" do
      Room.stub(:find).and_return(mock_room(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(rooms_url)
    end
  end
=end

