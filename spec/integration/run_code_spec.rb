require 'spec_helper'

describe 'Run Code post' do

   it 'should return 4 for a puts 2+2' do
    post '/run_code', {'input.language' => 'ruby', 'input.sourceCode' => 'puts 2+2', 'input.testCode' => 'puts 2+2'}
    response.body.should == "{\"output\": {\n  \"result\": \"4\\u000a4\\u000a\"\n}}"
   end

end
