require 'spec_helper'

require 'capybara/rails'

describe 'Login and session' do
  
  after(:each) do
    visit('/login/logout')
  end
 
  it 'should login with a valid name' do
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
    visit('/')
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
