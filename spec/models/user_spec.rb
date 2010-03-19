require 'spec_helper'

describe User do
  before(:each) do
    @valid_attributes = {
      :name => "value for name"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end
  
  it "should not allow two users with the same name" do
    User.create(:name => "test")
    invalid_user = User.create(:name => "test")
    invalid_user.should have(1).error_on(:name)
  end
  
  it "should not allow blank names" do
    invalid_user = User.create(:name => "")
    invalid_user.should have(1).error_on(:name)
  end

end
