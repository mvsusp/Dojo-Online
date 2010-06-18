require 'spec_helper'

describe CodeTestsAndResultsController do

    before do
        Room.destroy_all
        @lang = [Language.create(:name => 'Ruby'), Language.create({:name => 'Java'})]
        @room = Room.create({:name => "test1",:description => "something",:languages => @lang,
           :user=>User.create(:name=>'foo1')})
       cookies[:user] = 'foo1'
    end    

    it 'should get routed ok' do
        route_for(:controller => 'code_tests_and_results', :room_id => '3', :action => 'show').should == {:path => "/rooms/3/code_tests_and_results",
:method => 'get'}
        route_for(:controller => 'code_tests_and_results', :room_id => '3', :action => 'create').should == {:path => "/rooms/3/code_tests_and_results",
:method => 'post'}
    end

    it 'should return no code, tests and result in a newly created room' do
        get :show, :room_id => @room.id.to_s
        obj = ['', '', '']
        response.body.should == obj.to_json
    end
    
    it 'should include the code sent' do
        post :create , :room_id => @room.id.to_s, :code => 'puts "123"'
        @room.code.should == 'puts "123"'
    end
    
    it 'should return the included code' do
        get :show , :room_id => @room.id.to_s, :code => 'puts "1234"'
        obj = ['puts "1234"', '', '']
        get :show, :room_id => @room.id.to_s
        response.body.should == obj.to_json
    end

    it 'should include the tests sent' do
        post :create , :room_id => @room.id.to_s, :tests => 'puts "12345"'
        @room.code.should == 'puts "12345"'
    end

    it 'should return the included tests' do
        get :show , :room_id => @room.id.to_s, :tests => 'puts "12345"'
        obj = ['', 'puts "12345"', '']
        get :show, :room_id => @room.id.to_s
        response.body.should == obj.to_json
    end

    it 'should include the results sent' do
        post :create , :room_id => @room.id.to_s, :results => '123456'
        @room.code.should == '123456'
    end
    
    it 'should return the included results' do
        get :show , :room_id => @room.id.to_s, :results => '123456'
        obj = ['', '', '123456']
        get :show, :room_id => @room.id.to_s
        response.body.should == obj.to_json
    end

    it 'should include the code, tests and results sent' do
        post :create , :room_id => @room.id.to_s, :code => 'puts "123"', :tests => 'puts "1234"', :results => '1234'
        @room.code.should == 'puts "123"'
        @room.tests.should == 'puts "1234"'
        @room.results.should == '1234'
    end
    
    it 'should return the included code, tests and results' do
        get :show , :room_id => @room.id.to_s, :code => 'puts "123"', :tests => 'puts "1234"', :results => '1234'
        obj = ['puts "123"', 'puts "1234"', '1234']
        get :show, :room_id => @room.id.to_s
        response.body.should == obj.to_json 
    end
end
