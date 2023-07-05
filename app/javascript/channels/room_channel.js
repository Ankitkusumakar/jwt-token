import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to the room!");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    $('#msg').append('<div class="message"> ' + data.content + "Message sent by user"+ data.sent_by + '</div>')
  }
});
// let submit_messages;
// $(document).on('turbolinks:load', function () {
//   submit_messages()
// })
// submit_messages = function () {
//   $('#message_content').on('keydown', function (event) {
//     if (event.keyCode == 13) {
//       $('input').click()
//       event.target.value = ''
//       event.preventDefault()
//     }
//   })
// }