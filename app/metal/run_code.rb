# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)
require 'net/http'

class RunCode
  def self.call(env)
    if env["PATH_INFO"] =~ /^\/run_code/
      params = Rack::Request.new env 
      res = Net::HTTP.post_form(URI.parse('http://eclipse.ime.usp.br/Dojo-Online-Service/input/callInterpreter'), {'input.language'=>'ruby', 'input.sourceCode'=> params['input.sourceCode'],'input.testCode' => params['input.testCode']})
      [200, {"Content-Type" => "text/html"}, [res.body]]
    else
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end
  end
end


