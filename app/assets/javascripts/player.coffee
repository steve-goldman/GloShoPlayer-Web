class @Player
  constructor: (viewManager, webSocketWrapper) ->
    @viewManager      = viewManager
    @webSocketWrapper = webSocketWrapper
    @viewManager.setViewState ViewManager.NOT_CONNECTED

  #
  # calls from web socket wrapper
  #

  disconnected: =>
    @viewManager.setViewState ViewManager.DISCONNECTED

  unableToConnect: =>
    @viewManager.setViewState ViewManager.UNABLE_TO_CONNECT

  playerLoggedIn: =>
    @viewManager.setViewState ViewManager.WAITING_TO_START

  startingIn: (seconds) =>
    # TODO

  running: =>
    @viewManager.setViewState ViewManager.TORCH_OFF

  setTorchOn: =>
    @viewManager.setViewState ViewManager.TORCH_ON
    @webSocketWrapper.sendTorchStateSet()

  setTorchOff: =>
    @viewManager.setViewState ViewManager.TORCH_OFF
    @webSocketWrapper.sendTorchStateSet()

  done: =>
    @viewManager.setViewState ViewManager.DONE

  playTorchSeries: (message) =>
    # TODO

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
