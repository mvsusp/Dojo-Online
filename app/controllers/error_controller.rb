class ErrorController < ApplicationController


  # GET /error
  # GET /error.xml
  def index
  #  @rooms = Room.all

        #flash[:notice] = 'Room was successfully created.'

    respond_to do |format|
      format.html # index.html.erb
   #   format.xml  { render :xml => @rooms }
    end
  end

end
