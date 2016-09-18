class @WebSocketWrapperBuilder
  build: (serverUrl) =>
    playerId = (Math.random() + 1).toString(36).slice(2)
    return new WebSocketWrapper playerId, serverUrl

