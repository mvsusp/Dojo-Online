var server_time = 0;

function get_chats(room, callback) {
  
    $.getJSON('/chat', {'room': room, 'last_check': server_time}, callback)
}

function send_chat(message, room)
{
    $.post('/chat', {'message': message, 'room': room})
}

function add_to_chat_messages(res)
{
    var value = $('#chat_messages').html()
    if (res == null) return;
    messages = res['messages']
    for (var i = 0; i < messages.length; i++) {
        value += '(' + messages[i].time + ') <b>' + messages[i].poster + '</b>:' + messages[i].message +
            '<br />'
    }
    server_time = res['server_time']
    $('#chat_messages').html(value)
    $('#chat_messages').scrollTo('max')
    setTimeout(function () { 
        get_chats(1, add_to_chat_messages)
    }, 1000);
}

$(document).ready( 
    function () {
        $("#send_chat").submit(
            function () {
                send_chat($('#chat_message').val(), 1)
                $('#chat_message').val('')
                return false
            }
        )
      setTimeout(function () { 
                      get_chats(1, add_to_chat_messages)
                  }, 1000);
        
    }
);
