# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)
require 'cgi'

class Chat
  def self.call(env)
    path = env["PATH_INFO"]
    if path =~ /^\/chat\/?/
      session = Rack::Request.new env 
      method = env["REQUEST_METHOD"]
      error = session_error(session, method)
      return [400, {"Content-Type" => "text/html"}, [error]] if not error.empty?
      room = Room.find(session["room"].to_i)
      if method == "GET"
        last_check = Time.at(session['last_check'].to_i).utc
        json_res = {:server_time => Time.now.to_i}
        
        messages_since_last_check = room.chat_messages.find(:all, :conditions => ['created_at >= ?', last_check])
        messages = messages_since_last_check.map do |message| 
          {:poster => message.poster, :message => CGI.escapeHTML(message.message), :time => message.updated_at.strftime("%T")}
        end
        json_res[:messages] =  messages
        
        return [200, {"Content-Type" => "text/html"}, [json_res.to_json]]
      elsif method == "POST"
        new_chat = ChatMessage.create(:message => session["message"], :poster => session.cookies["user"])
        room.chat_messages << new_chat
        room.save
        return [200, {"Content-Type" => "text/html"}, ""]
      end
    end
    return [404, {"Content-Type" => "text/html"}, ["Not Found"]]
  end


  def self.session_error(session, method)
    return 'No room received' if session["room"].to_i == 0 
    return 'Not logged in' if (not session.cookies['user']) or session.cookies["user"].empty?
    return 'Non-existent room' if Room.find(:first, :conditions => {:id => session['room'].to_i}) == nil
    if method == "POST"
      return 'Empty message' if (not session['message']) or session['message'].empty?
    end 
    return ""
  end
end
