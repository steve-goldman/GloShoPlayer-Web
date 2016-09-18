class @PlayerBuilder
  build: (serverUrl, doneDelay) =>
    viewManager             = new ViewManager()
    webSocketWrapper        = new WebSocketWrapperBuilder().build(serverUrl)
    torchNotesPlayerBuilder = new TorchNotesPlayerBuilder(doneDelay)
    torchNotesPlayerStarter = new TorchNotesPlayerStarter()
    noSleep                 = new NoSleep()

    player = new Player viewManager, webSocketWrapper, torchNotesPlayerBuilder, torchNotesPlayerStarter, noSleep

    webSocketWrapper.setListener        player
    torchNotesPlayerBuilder.setListener player
    new ClickListener().setListener     player

    return player
