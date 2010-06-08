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
    page.should have_content('Batman')
    page.should have_content('Saint description, Batman!')
    visit('/rooms')
    page.should have_content('Bat-cave')
    page.should have_content('Saint description, Batman!')
  end

  it 'should not allow two rooms with the same name' do
    visit('/rooms/new')
    fill_in('room[name]', :with => 'This name is taken')
    fill_in('room[description]', :with => ':)')
    check('room[language_ids][]')
    click_button('Create')
    visit('/rooms')
    page.should have_content(':)')
    
    visit('/rooms/new')
    fill_in('room[name]', :with => 'This name is taken')
    fill_in('room[description]', :with => ':(')
    check('room[language_ids][]')
    click_button('Create')
    page.should have_content('Name has already been taken')
    visit('/rooms')
    page.should_not have_content(':(')
  end
  
  it 'should create a room with a valid name' do
    visit('/')
    visit('/rooms/new')
    fill_in('room[name]', :with => 'Test')
    fill_in('room[description]', :with => 'something')
    check('room[language_ids][]')
    click_button('Create')
    page.should have_content('Test')
  end
  
  it 'should create a rooms with long description and show truncated' do
      visit('/')
      visit('/rooms/new')
      fill_in('room[name]', :with => 'Test3527')
      fill_in('room[description]', :with => 'The quick brown fox jumps over the lazy dog.')
      check('room[language_ids][]')
      click_button('Create')
      page.should have_content('The quick brown fox jumps over...')
      page.should_not have_content('The quick brown fox jumps over the lazy dog.')
      click_button('[+]')
      page.should_not have_content('The quick brown fox jumps over...')
      page.should have_content('The quick brown fox jumps over the lazy dog.')
    end

end
