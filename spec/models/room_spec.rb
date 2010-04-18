require 'spec_helper'

describe Room do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :description => "value for description"
    }
  end

  it "should create a new instance given valid attributes" do
    Room.create!(@valid_attributes)
  end
end
