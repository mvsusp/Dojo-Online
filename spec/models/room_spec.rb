require 'spec_helper'

describe Room do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    Room.create!(@valid_attributes)
  end
end
