class RoomsController < ApplicationController
  # GET /rooms
  # GET /rooms.xml
  def index
    @rooms = Room.find(:all, :conditions => {:initiated => true})
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rooms }
    end
  end


  # GET /rooms/1
  # GET /rooms/1.xml
  # GET /rooms/1.json
  def show
    @room = Room.find(params[:id])
    @owner = (@room.is_in_the_room.find :first, :conditions => {:owner=>true}).user
    @user = User.find(:first, :conditions => {:name => cookies[:user]})
    @is_pilot = @owner == @user
    @room.add_user(@user, @is_pilot)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @room }
      format.json { render :json => @room }
    end
  end

  # GET /rooms/new
  # GET /rooms/new.xml
  def new
    @room = Room.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @room }
    end
  end

  # POST /rooms
  # POST /rooms.xml
  def create
    @user = User.find(:first, :conditions => {:name => cookies[:user]})
    @room = Room.new(params[:room])
    @room.initiated = true

    respond_to do |format|
      if @room.save
        @room.add_user(@user, true)
        format.html { redirect_to(@room) }
        format.xml  { render :xml => @room, :status => :created, :location => @room }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @room.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rooms/1
  # PUT /rooms/1.xml
  def update
    @room = Room.find(params[:id])
    @owner = (@room.is_in_the_room.find :first, :conditions => {:owner=>true}).user
    @user = User.find(:first, :conditions => {:name => cookies[:user]})
    @is_pilot = @owner == @user
    
    if @is_pilot
      @room.source_code = params[:source_code]
      @room.test_code = params[:test_code]
      @room.code_result = params[:code_result]
    end
    
    respond_to do |format|
      if @room.save
        format.html { render 'edit'}
        format.xml  { render :xml => @room, :status => :created, :location => @room }
      else
        format.html { render 'edit' }
        format.xml  { render :xml => @room.errors, :status => :unprocessable_entity }
      end
    end
  end

end
