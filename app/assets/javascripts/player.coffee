class @Player
  constructor: (viewManager, webSocketWrapper, torchNotesPlayerBuilder, torchNotesPlayerStarter, noSleep, locateMeCountdown, donePlayingNotifier, loginInterval) ->
    @viewManager             = viewManager
    @webSocketWrapper        = webSocketWrapper
    @torchNotesPlayerBuilder = torchNotesPlayerBuilder
    @torchNotesPlayerStarter = torchNotesPlayerStarter
    @noSleep                 = noSleep
    @locateMeCountdown       = locateMeCountdown
    @donePlayingNotifier     = donePlayingNotifier
    @loginInterval           = loginInterval
    @viewManager.setViewState ViewManager.EMPTY

  open: =>
    @webSocketWrapper.open()

  #
  # calls from web socket wrapper
  #

  disconnected: =>
    @viewManager.setViewState ViewManager.NO_SHOW
    @noSleep.disable()
    @locateMeCountdown.stop()
    this._retryLogin()

  unableToConnect: =>
    @viewManager.setViewState ViewManager.NO_SHOW
    this._retryLogin()

  playerLoggedIn: =>
    @viewManager.setViewState ViewManager.WAITING_TO_START

  startingIn: (seconds) =>
    @viewManager.setStartingIn seconds

  running: =>
    @viewManager.setViewState ViewManager.TORCH_OFF

  setTorchOn: =>
    @viewManager.setViewState ViewManager.TORCH_ON

  setTorchOnAndAck: =>
    this.setTorchOn()
    @webSocketWrapper.sendTorchStateSet()

  setTorchOff: =>
    @viewManager.setViewState ViewManager.TORCH_OFF

  setTorchOffAndAck: =>
    this.setTorchOff()
    @webSocketWrapper.sendTorchStateSet()

  done: =>
    @torchNotesPlayerStarter.close()
    @viewManager.setViewState ViewManager.DONE
    @webSocketWrapper.sendTorchSeriesPlayed()
    @donePlayingNotifier.notify()

  playTorchSeries: (torchNotes, localStartTime) =>
    torchNotesPlayer = @torchNotesPlayerBuilder.build torchNotes
    @torchNotesPlayerStarter.update localStartTime, torchNotesPlayer

  canBeLocated: =>
    @viewManager.setViewState ViewManager.READY_TO_LOCATE

  cannotBeLocated: =>
    @viewManager.setViewState ViewManager.WAITING_TO_START

  found: =>
    @viewManager.setViewState ViewManager.FOUND

  notFound: =>
    @viewManager.setViewState ViewManager.NOT_FOUND

  showInfo: (showId) =>
    if showId.localeCompare(Cookies.get('current_show_id')) == 0
      @webSocketWrapper.login()
    else
      @showId = showId
      @viewManager.setViewState ViewManager.JOINABLE

  playerLoginError: =>
    @viewManager.setViewState ViewManager.NO_SHOW
    this._retryLogin()

  #
  # calls from button clicks
  #

  join: =>
    Cookies.set 'current_show_id', @showId
    @webSocketWrapper.login()
    @donePlayingNotifier.init()
    @noSleep.enable()

  leave: =>
    @webSocketWrapper.close()
    Cookies.remove 'current_show_id'
    this.open()

  locateMe: =>
    @locateMeCountdown.start()

  #
  # calls from the LocateMeCountdown
  #

  locatingIn: (seconds) =>
    if seconds == 0
      @webSocketWrapper.sendLocateMe()
    else
      this.startingIn seconds

  #
  # helpers
  #

  _retryLogin: =>
    setTimeout this.open, @loginInterval
