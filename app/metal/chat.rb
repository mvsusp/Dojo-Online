# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)

class Chat
  def self.call(env)
    path = env["PATH_INFO"]
    if path =~ /^\/chat\/?/
      session = Rack::Request.new env 
      return [400, {"Content-Type" => "text/html"}, ['']] if session["room"].to_i == 0 or 
        not session.cookies['user'] or
        (session.cookies["user"] and session.cookies["user"].empty?)
        
      if env["REQUEST_METHOD"] == "GET"
        room = Room.find(session["room"].to_i)
        messages = room.chat_messages.map do |message|
          {:poster => message.poster, :message => message.message}
        end
        [200, {"Content-Type" => "text/html"}, [messages.to_json]]
      else
        return [400, {"Content-Type" => "text/html"}, ['']] if (not session['message']) or
          session['message'].empty?
        room = Room.find(session["room"].to_i)
        new_chat = ChatMessage.create(:message => session["message"], :poster => session.cookies["user"])
        room.chat_messages << new_chat
        room.save
        [200, {"Content-Type" => "text/html"}, [""]]
      end
    else
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end
  end
end
