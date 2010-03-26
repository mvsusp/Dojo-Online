require 'spec_helper'

require 'capybara/rails'

describe 'Login and session' do
  
  after(:all) do
    visit('/login/logout')
  end
 
  it 'should login with a valid name' do
    visit('/')
    fill_in('user[name]', :with => 'Lucas')
    click_button('Login')
    page.should have_content('Lucas')
  end

end

describe 'Logout' do
  
  before(:all) do
    visit('/')
    fill_in('user[name]', :with => 'Lucas')
    click_button('Login')
  end
  
  it 'should remember your username' do
    visit('/')
    page.should have_content('Lucas')
  end
  
  it 'should logout' do 
    visit('/login/logout')
    page.should have_no_content('Lucas')
  end

end