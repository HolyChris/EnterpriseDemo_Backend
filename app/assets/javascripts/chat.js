function printMessage(message) {

  var elem = $('.message-area');
  var html;

  if (message.author === "Jesse Litton") {
    html = elem.append(
      $('<div/>', {'class': 'message-row'}).append(
        $('<div/>', {'class': 'sent message'}).append(
            $('<div/>', {'class': 'message-text', text: message.body})
          )
        .append(
          $('<div/>', {'class': 'username', text: message.author})
        )
      )
    );
  } else {
    html = elem.append(
      $('<div/>', {'class': 'message-row'}).append(
        $('<div/>', {'class': 'received message'}).append(
            $('<div/>', {'class': 'message-text', text: message.body})
          .append(
            $('<div/>', {'class': 'username', text: message.author})
          )
        )
      )
    );
  }

  elem.animate({
   scrollTop: 100000000000
  }, 300);
  return html;

}

function printJoined(message) {
  $('.joined').append(message + "<br>");
}

$(function() {
    var chatChannel;
    var username;


    function setupChannel() {
        chatChannel.join().then(function(channel) {
            printJoined(username + ' joined the chat.');
        });

        chatChannel.on('messageAdded', function(message) {
            printMessage(message);
         });
    }

    var $input = $('.message-composer');
    $input.on('keydown', function(e) {
        if (e.keyCode == 13) {
          chatChannel.sendMessage($input.val());
          $input.val('');
          console.log('key pressed')
        }
     });



$.post("/twilio_tokens", function(data) {
    username = data.username;
    var accessManager = new Twilio.AccessManager(data.token);
    var messagingClient = new Twilio.IPMessaging.Client(accessManager);

    messagingClient.getChannelByUniqueName('chat').then(function(channel) {
	if (channel) {
	    chatChannel = channel;
	    setupChannel();
	} else {
	    messagingClient.createChannel({
		uniqueName: 'chat',
		friendlyName: 'startclosing-staging' })
	    .then(function(channel) {
		chatChannel = channel;
		setupChannel();
	    });
	}
    });
});

});

