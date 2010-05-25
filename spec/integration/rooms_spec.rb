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

  #after(:each) do
  #  visit('/login/logout')
  #end
    
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

  it 'should often update source code, test code and code results' do
    visit('/rooms/new')
    fill_in('room[name]', :with => 'Bat-cave2')
    fill_in('room[description]', :with => 'Saint description, Batman!')
    check('room[language_ids][]')
    click_button('Create')   
    @room = Room.find :first, :conditions => { :name => 'Bat-cave2' }
    page.should_not have_content('puts 2')
    #@room.source_code = 'puts 2'
    #@room.save (1)
    #Room.update @room.id, { :source_code => 'puts 2' }
    sleep 5
    #page.should have_content('puts 2')
  end

  #it 'should create a room with a valid name' do
  #  visit('/')
  #  fill_in('user[name]', :with => 'Lucas')
  #  click_button('Login')
  #  page.should have_content('Lucas')
  #  visit('/rooms')
  #  click_button('New room')
  #  fill_in('room[name]', :with => 'Test')
  #  fill_in('room[description]', :with => 'something')
  #  fill_in('room[language_ids][]', :with => '[1]')
  #  click_button('Create')
  #  page.should have_content('Test')
  #end

end
