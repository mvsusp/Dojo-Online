require 'spec_helper'

describe "/rooms/edit.html.erb" do
  include RoomsHelper

  before(:each) do
    assigns[:room] = @room = stub_model(Room,
      :new_record? => false,
      :name => "value for name",
      :description => "value for description"
    )
  end

  it "renders the edit room form" do
    render

    response.should have_tag("form[action=#{room_path(@room)}][method=post]") do
      with_tag('input#room_name[name=?]', "room[name]")
      with_tag('input#room_description[name=?]', "room[description]")
    end
  end
end
