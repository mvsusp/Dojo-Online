require 'spec_helper'

describe "/rooms/index.html.erb" do
  include RoomsHelper

  before(:each) do
    assigns[:rooms] = [
      stub_model(Room,
        :name => "value for name",
        :description => "value for description"
      ),
      stub_model(Room,
        :name => "value for name",
        :description => "value for description"
      )
    ]
  end

  it "renders a list of rooms" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for description".to_s, 2)
  end
end
