class @Message
  constructor: (messageType) ->
    @dict = {}
    @dict.messageType = messageType
    @dict.timestamp   = new Date().getTime()

  put: (key, value) =>
    @dict[key] = value

  send: (webSocket) =>
    console.log 'tx', @dict
    webSocket.send JSON.stringify(@dict)
