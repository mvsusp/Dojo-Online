require 'spec_helper'

describe Language do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :room_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Language.create!(@valid_attributes)
  end
end
