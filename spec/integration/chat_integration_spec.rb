require 'spec_helper'

describe 'Chat Messages post and list' do
  it 'should create a new ChatMessage' do
    post('/chat/', :room => 123, :message => "test1")
        
  end


end

