function get_chats(room, callback) {
    $.getJSON('/chat', {'room': room}, callback)
}

function send_chat(message, room)
{
    $.post('/chat', {'message': message, 'room': room})
}

function add_to_chat_messages(messages)
{
    var value = ''
    for (var i = 0; i < messages.length; i++) {
        value += '<b>' + messages[i].poster + '</b>:' + messages[i].message +
            '<br />'
    }

    $('#chat_messages').html(value)
    $('#chat_messages').scrollTo('max')

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
      
      setInterval(function () { 
                      get_chats(1, add_to_chat_messages)
                  }, 1000);
        
    }
);
