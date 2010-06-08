require 'spec_helper'

require 'capybara/rails'

describe 'Login and session' do
  before(:each) do
    visit('/login/logout')
  end
  
  after(:each) do
    visit('/login/logout')
  end
 
  it 'should login with a valid name' do
    User.destroy_all
    visit('/')
    fill_in('user[name]', :with => 'Lucas')
    click_button('Login')
    page.should have_content('Lucas')
  end

 
  it 'should not login with a blank name' do
    visit('/')
    fill_in('user[name]', :with => '')
    click_button('Login')
    page.should have_content('Error')
  end


end

describe 'Logout' do
  
  before(:all) do
    User.destroy_all
    visit('/')
    visit('/login/logout')
    fill_in('user[name]', :with => 'Lucas')
    click_button('Login')
  end
  
  it 'should remember your username' do
    visit('/rooms')
    page.should have_content('Lucas')
  end
  
  it 'should logout' do 
    visit('/login/logout')
    page.should have_no_content('Lucas')
  end

end

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
end