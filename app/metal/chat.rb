# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)

class Chat
  def self.call(env)
    path = env["PATH_INFO"]
    if path =~ /^\/chat\/?/
      session = Rack::Request.new env
      room = session["room"].to_i
      if env["REQUEST_METHOD"] == "GET"
        chats = ChatMessage.find :all
        json = "["
        for chat in chats
          json = json + "{user_name: \"" + chat[:poster] + "\", message: \"" + 
            chat[:message] + "\"},"
        end
        json = json[0..-1] + "]"
        puts json
        [200, {"Content-Type" => "text/html"}, [""]]
      else
        generate new ChatMessage
        new_chat = ChatMessage.new
        new_chat[:message] = session["message"]
        new_chat[:poster] = session.cookies["user"]
        #new_chat[:room] = session["room"] #  rooms do not exist yet
        new_chat.save
        [200, {"Content-Type" => "text/html"}, [""]]
      end
    else
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end
  end
end
