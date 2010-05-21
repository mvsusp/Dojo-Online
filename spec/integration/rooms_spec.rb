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
  end
  
  after(:each) do
    Room.destroy_all
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
    room = Room.find :first, :conditions => {:name => 'Bat-cave'}
  end

  it 'should refresh automatically every 10 seconds' do
    visit('/rooms')
    @user = User.find(:first, :conditions => {:name => 'Batman'})
    page.should_not have_content('Hall of Justice')
    room = Room.create! :languages => [@l], 
                        :description => 'Room of the Super-Friends',
                        :user => @user,
                        :name => 'Hall of Justice',
                        :initiated => true
    sleep 12
    visit('/rooms')
    page.should have_content('Hall of Justice')
  end                                                           

end
