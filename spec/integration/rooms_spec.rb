require 'spec_helper'
require 'capybara/rails'

describe "Rooms" do

  before(:all) do
    Room.destroy_all
    User.destroy_all
    Language.destroy_all
    @l = Language.create!(:name => 'Klingon')
    visit('/')
    fill_in('user[name]', :with => 'Batman')
    click_button('Login')
    @user = User.find(:first, :conditions => {:name => 'Batman'})
  end

  it 'should create rooms and show them in the room list' do
    visit('/rooms/new')
    fill_in('room[name]', :with => 'Bat-cave')
    fill_in('room[description]', :with => 'Saint description, Batman!')
    check('room[language_ids][]')
    click_button('Create')
    page.should have_content('Welcome to the room Bat-cave, Batman')
    page.should have_content('The owner name is Batman')
    page.should have_content('Saint description, Batman!')
    visit('/rooms')
    page.should have_content('Bat-cave')
    page.should have_content('Saint description, Batman!')
  end

  it 'should display a "run" button only for the owner' do
    visit('/rooms/new')
    fill_in('room[name]', :with => 'Return of the Bat-cave')
    fill_in('room[description]', :with => 'Welcome to my cave. Again')
    check('room[language_ids][]')
    click_button('Create')
    room = Room.find :first, :conditions => {:name => 'Return of the Bat-cave'}
    button = find_button('Run')
    button.should_not == nil
    visit('/login/logout')
    fill_in('user[name]', :with => 'Robin')
    click_button('Login')
    visit('/rooms/' + room.id.to_s)
    button = find_button('Run')
    button.should == nil
  end

end
