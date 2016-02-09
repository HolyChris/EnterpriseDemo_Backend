function printMessage(message) {
  // $('.message-text').append(message + "<br>");

  // var $messageRow = $( "<div/>", { class: "message-row"}),
  //       $receivedMessage = $( "<div/>", { class: "received message"}),
  //         $messageRow = $( "<div/>", { class: "message-row"}),

  var elem = $('.message-area');

  elem.append(
    $('<div/>', {'class': 'message-row'}).append(
      $('<div/>', {'class': 'received message'}).append(
          $('<div/>', {'class': 'message-text'}).append(
              $('<span/>', {text: message.body})
            )
        .append(
          $('<div/>', {'class': 'username'}).append(
              $('<span/>', {text: message.author})
          )
        )
      )
    )
  );
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

