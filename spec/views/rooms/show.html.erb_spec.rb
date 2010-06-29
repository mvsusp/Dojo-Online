require 'spec_helper'

describe "/rooms/show.html.erb" do
  include RoomsHelper
  before(:each) do
    assigns[:room] = @room = stub_model(Room,
      :name => "value for name",
      :description => "value for description"
    )
    assigns[:user] = @owner = stub_model(User, :name => 'Batman')
    assigns[:owner] = @owner = stub_model(User, :name => 'Batman')
  end
end
