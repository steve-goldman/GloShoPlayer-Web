class @Message
  constructor: (messageType) ->
    @dict = {}
    @dict.messageType = messageType

  put: (key, value) =>
    @dict[key] = value

  send: (webSocket) =>
    @dict.timestamp = Math.round performance.now()
    console.log 'tx', @dict
    webSocket.send JSON.stringify(@dict)
