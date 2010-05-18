# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)

class Chat
  def self.call(env)
    if env["PATH_INFO"] =~ /^\/chat/
      session = Rack::Request.new env 
      method = env['REQUEST_METHOD']
      user = session.cookies['user']
      error = session_error(session, method)
      return [400, {"Content-Type" => "text/html"}, [error]] if not error.empty?
      if method == 'POST' 
        chat = ChatMessage.create :message => session['message'], :poster => user, :room_id => session['room']
      end
      return [200, {"Content-Type" => "text/html"}, ["Hello, World!"]]
    else
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end
  end
  
  def self.session_error(session, method)
    return 'Empty message' if (method == 'POST' and session['message'].empty?)
    return 'No room received' if session['room'] == nil
    return 'Not logged in' if session.cookies['user'].nil? or session.cookies['user'].empty?
    return 'Room not found' if (Room.find :first, :conditions => {:id => session['room'].to_i}).nil?
    return ''
  end
end
