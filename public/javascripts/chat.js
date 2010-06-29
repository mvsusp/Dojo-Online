function get_chats(room, callback) {
    $.getJSON('/chat', {'room': room}, callback)
}

function send_chat(message, room)
{
    $.post('/chat', {'message': message, 'room': room})
    $('#send_message').attr('disabled', true);
    var value = $('#chat_messages').html();
    value += '( -- ) <b>' + user_name + '</b>:' + message +
            '<br />'
    $('#chat_messages').html(value)
    $('#chat_messages').scrollTo('max')
}

function convertStrToData(strData){
    data = strData.split(':')
    hora = data[0].substring(data[0].length - 2);
    minuto = data[1]
    segundo = data[2].substring(0, 2);
    return '(' + hora + ':' + minuto + ':' + segundo + ')'
}

function add_to_chat_messages(messages)
{
    var value = ''
    if (messages == null) return;
    for (var i = 0; i < messages.length; i++) {
	msg = messages[i].chat_message
    value += convertStrToData(msg.created_at) + '<b>' + msg.poster + '</b>:' + msg.message +
            '<br />'
    }
    $('#chat_messages').html(value)
    $('#chat_messages').scrollTo({top:'100%', left:0})
    $('#send_message').attr('disabled', false);
    setTimeout(function () { 
        get_chats(room_id, add_to_chat_messages)
    }, 1000);
}
1
$(document).ready( 
    function () {
        $("#send_chat").submit(
            function () {
                send_chat($('#chat_message').val(), room_id)
                $('#chat_message').val('')
                return false
            }
        )

      setTimeout(function () { 
                      get_chats(room_id, add_to_chat_messages)
                  }, 1000);
        
    }
);
