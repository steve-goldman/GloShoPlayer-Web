class @PlayerBuilder
  build: (serverUrl, doneDelay) =>
    viewManager             = new ViewManager()
    webSocketWrapper        = new WebSocketWrapperBuilder().build(serverUrl)
    torchNotesPlayerBuilder = new TorchNotesPlayerBuilder(doneDelay)
    torchNotesPlayerStarter = new TorchNotesPlayerStarter()

    player = new Player viewManager, webSocketWrapper, torchNotesPlayerBuilder, torchNotesPlayerStarter

    webSocketWrapper.setListener        player
    torchNotesPlayerBuilder.setListener player
    new ClickListener().setListener     player

    return player
