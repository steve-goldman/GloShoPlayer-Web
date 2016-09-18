class @WebSocketWrapper
  constructor: (playerId, serverUrl) ->
    @playerId  = playerId
    @serverUrl = serverUrl

  setListener: (listener) =>
    @listener = listener
    return this

  open: =>
    console.log 'opening connection', @serverUrl
    @hasConnected        = false
    @webSocket           = new WebSocket @serverUrl
    @webSocket.onopen    = this._onOpen
    @webSocket.onmessage = this._onMessage
    @webSocket.onclose   = this._onClose
    @webSocket.onerror   = this._onError

  close: =>
    console.log 'closing connection'
    @webSocket.close()

  sendLocateMe: =>
    new Message('ready-to-locate').send(@webSocket)

  sendTorchStateSet: =>
    new Message('torch-state-set').send(@webSocket)
  
  _onOpen: =>
    this._login()

  _onMessage: (event) =>
    console.log 'rx', event
    message = JSON.parse event.data
    switch message.messageType
      when 'ping'              then this._ping()
      when 'player-logged-in'  then this._playerLoggedIn()
      when 'starting-in'       then this._startingIn message
      when 'running'           then this._running()
      when 'set-torch-on'      then this._setTorchOn()
      when 'set-torch-off'     then this._setTorchOff()
      when 'done'              then this._done()
      when 'play-torch-series' then this._playTorchSeries message
      when 'can-be-located'    then this._canBeLocated()
      when 'cannot-be-located' then this._cannotBeLocated()
      when 'found'             then this._found()
      when 'not-found'         then this._notFound()
  
  _onClose: =>
    if @hasConnected
      @listener.disconnected()
    else
      @listener.unableToConnect()

  _onError: (event) =>
    console.log 'onError', event

  _login: =>
    new LoginMessage(@playerId).generate().send(@webSocket)

  _ping: =>
    new Message('pong').send(@webSocket)

  _playerLoggedIn: =>
    @hasConnected = true
    @listener.playerLoggedIn()

  _startingIn: (message) =>
    @listener.startingIn message.seconds

  _running: =>
    @listener.running()

  _setTorchOn: =>
    @listener.setTorchOn()

  _setTorchOff: =>
    @listener.setTorchOff()

  _done: =>
    @listener.done()

  _playTorchSeries: (message) =>
    # TODO

  _canBeLocated: =>
    @listener.canBeLocated()

  _cannotBeLocated: =>
    @listener.cannotBeLocated()

  _found: =>
    @listener.found()

  _notFound: =>
    @listener.notFound()
