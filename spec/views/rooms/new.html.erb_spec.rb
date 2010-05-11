require 'spec_helper'

describe "/rooms/new.html.erb" do
  include RoomsHelper

  before(:each) do
    assigns[:room] = stub_model(Room,
      :new_record? => true,
      :name => "value for name",
      :description => "value for description"
    )
  end

  it "renders new room form" do
    render

    response.should have_tag("form[action=?][method=post]", rooms_path) do
      with_tag("input#room_name[name=?]", "room[name]")
      with_tag("textarea#room_description[name=?]", "room[description]")
    end
  end
end
