class @Player
  constructor: ->
    socket = new WebSocket('ws://192.168.0.10:8080');
    socket.onopen = (event) ->
      console.log 'socket opened'
