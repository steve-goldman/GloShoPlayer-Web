class @ViewManager
  @CONNECTING        = 1
  @UNABLE_TO_CONNECT = 2
  @DISCONNECTED      = 3
  @LOGGING_IN        = 4
  @WAITING_TO_START  = 5
  @STARTING_IN       = 6
  @TORCH_OFF         = 7
  @TORCH_ON          = 8
  @DONE              = 9
  @READY_TO_LOCATE   = 10
  @FOUND             = 11
  @NOT_FOUND         = 12
  @NOT_CONNECTED     = 13
  @FLASH_TESTING     = 14

  constructor: ->
    @elements          = []
    @stateViews        = {}

    this._initElements()
    this._initStateViews()

  setViewState: (state) =>
    this._hideAll()
    for element in @stateViews[state]
      element.show()

  setStartingIn: (seconds) =>
    this.setViewState ViewManager.STARTING_IN
    @startingIn.html('Starting in ' + seconds + " seconds")

  _getElement: (jqueryId) =>
    element = $(jqueryId)
    @elements.push element
    return element

  _hideAll: =>
    for element in @elements
      element.hide()

  _initElements: =>
    @connecting      = this._getElement '.info#connecting'
    @unableToConnect = this._getElement '.info#unable-to-connect'
    @disconnected    = this._getElement '.info#disconnected'
    @loggingIn       = this._getElement '.info#logging-in'
    @waitingToStart  = this._getElement '.info#waiting-to-start'
    @startingIn      = this._getElement '.info#starting-in'
    @running         = this._getElement '.info#running'
    @done            = this._getElement '.info#done'
    @found           = this._getElement '.info#found'
    @notFound        = this._getElement '.info#not-found'
    @torchOn         = this._getElement '.fullscreen#torch-on'
    @torchOff        = this._getElement '.fullscreen#torch-off'
    @connect         = this._getElement '.action#connect'
    @disconnect      = this._getElement '.action#disconnect'
    @locateMe        = this._getElement '.action#locate-me'

  _initStateViews: =>
    @stateViews[ViewManager.CONNECTING]        = [ @connecting ]
    @stateViews[ViewManager.UNABLE_TO_CONNECT] = [ @unableToConnect, @connect ]
    @stateViews[ViewManager.DISCONNECTED     ] = [ @disconnected, @connect ]
    @stateViews[ViewManager.LOGGING_IN       ] = [ @loggingIn, @disconnect ]
    @stateViews[ViewManager.WAITING_TO_START ] = [ @waitingToStart, @disconnect ]
    @stateViews[ViewManager.STARTING_IN      ] = [ @startingIn, @disconnect ]
    @stateViews[ViewManager.TORCH_OFF        ] = [ @torchOff ]
    @stateViews[ViewManager.TORCH_ON         ] = [ @torchOn ]
    @stateViews[ViewManager.DONE             ] = [ @done, @disconnect ]
    @stateViews[ViewManager.READY_TO_LOCATE  ] = [ @locateMe, @disconnect ]
    @stateViews[ViewManager.FOUND            ] = [ @found, @disconnect ]
    @stateViews[ViewManager.NOT_FOUND        ] = [ @notFound, @locateMe, @disconnect ]
    @stateViews[ViewManager.NOT_CONNECTED    ] = [ @connect ]
