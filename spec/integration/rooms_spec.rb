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

end
