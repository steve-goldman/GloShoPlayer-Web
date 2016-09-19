class @PlayerBuilder
  build: (serverUrl, doneDelay, locateMeSeconds) =>
    viewManager             = new ViewManager()
    webSocketWrapper        = new WebSocketWrapperBuilder().build(serverUrl)
    torchNotesPlayerBuilder = new TorchNotesPlayerBuilder(doneDelay)
    torchNotesPlayerStarter = new TorchNotesPlayerStarter()
    noSleep                 = new NoSleep()
    locateMeCountdown       = new LocateMeCountdown(locateMeSeconds)
    donePlayingNotifier     = new DonePlayingNotifier()

    player = new Player viewManager, webSocketWrapper, torchNotesPlayerBuilder, torchNotesPlayerStarter, noSleep, locateMeCountdown, donePlayingNotifier

    webSocketWrapper.setListener        player
    torchNotesPlayerBuilder.setListener player
    new ClickListener().setListener     player
    locateMeCountdown.setListener       player

    return player
