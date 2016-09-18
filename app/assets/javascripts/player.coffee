class @Player
  constructor: (viewManager, webSocketWrapper, torchNotesPlayerBuilder, torchNotesPlayerStarter, noSleep) ->
    @viewManager             = viewManager
    @webSocketWrapper        = webSocketWrapper
    @torchNotesPlayerBuilder = torchNotesPlayerBuilder
    @torchNotesPlayerStarter = torchNotesPlayerStarter
    @noSleep                 = noSleep
    @viewManager.setViewState ViewManager.NOT_CONNECTED

  #
  # calls from web socket wrapper
  #

  disconnected: =>
    @viewManager.setViewState ViewManager.DISCONNECTED
    @noSleep.disable()

  unableToConnect: =>
    @viewManager.setViewState ViewManager.UNABLE_TO_CONNECT

  playerLoggedIn: =>
    @viewManager.setViewState ViewManager.WAITING_TO_START
    @noSleep.enable()

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

  #
  # calls from button clicks
  #

  connect: =>
    console.log 'player connect'
    @webSocketWrapper.open()

  disconnect: =>
    @webSocketWrapper.close()

  locateMe: =>
    # TODO: user needs time to turn phone around
    @webSocketWrapper.sendLocateMe()
