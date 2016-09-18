class @PlayerBuilder
  build: (serverUrl) =>
    viewManager      = new ViewManager()
    webSocketWrapper = new WebSocketWrapperBuilder().build(serverUrl)

    player = new Player viewManager, webSocketWrapper

    webSocketWrapper.setListener player
    new ClickListener().setListener player

    return player
