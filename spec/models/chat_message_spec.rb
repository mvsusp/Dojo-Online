require 'spec_helper'

describe ChatMessage do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    ChatMessage.create!(@valid_attributes)
  end
end
