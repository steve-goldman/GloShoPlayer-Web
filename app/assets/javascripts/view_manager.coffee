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

  _getElement: (jqueryId) =>
    element = $(jqueryId)
    @elements.push element
    return element

  _hideAll: =>
    for element in @elements
      element.hide()

  _initElements: =>
    @connecting        = this._getElement '.info#connecting'
    @unable_to_connect = this._getElement '.info#unable-to-connect'
    @disconnected      = this._getElement '.info#disconnected'
    @logging_in        = this._getElement '.info#logging-in'
    @waiting_to_start  = this._getElement '.info#waiting-to-start'
    @starting_in       = this._getElement '.info#starting-in'
    @running           = this._getElement '.info#running'
    @done              = this._getElement '.info#done'
    @found             = this._getElement '.info#found'
    @not_found         = this._getElement '.info#not-found'
    @torch_on          = this._getElement '.fullscreen#torch-on'
    @torch_off         = this._getElement '.fullscreen#torch-off'
    @connect           = this._getElement '.action#connect'
    @disconnect        = this._getElement '.action#disconnect'
    @locate_me         = this._getElement '.action#locate-me'

  _initStateViews: =>
    @stateViews[ViewManager.CONNECTING]        = [ @connecting ]
    @stateViews[ViewManager.UNABLE_TO_CONNECT] = [ @unable_to_connect, @connect ]
    @stateViews[ViewManager.DISCONNECTED     ] = [ @disconnected, @connect ]
    @stateViews[ViewManager.LOGGING_IN       ] = [ @logging_in, @disconnect ]
    @stateViews[ViewManager.WAITING_TO_START ] = [ @waiting_to_start, @disconnect ]
    @stateViews[ViewManager.STARTING_IN      ] = [ @starting_in, @disconnect ]
    @stateViews[ViewManager.TORCH_OFF        ] = [ @torch_off ]
    @stateViews[ViewManager.TORCH_ON         ] = [ @torch_on ]
    @stateViews[ViewManager.DONE             ] = [ @done, @connect ]
    @stateViews[ViewManager.READY_TO_LOCATE  ] = [ @locate_me, @disconnect ]
    @stateViews[ViewManager.FOUND            ] = [ @found, @disconnect ]
    @stateViews[ViewManager.NOT_FOUND        ] = [ @not_found, @disconnect ]
    @stateViews[ViewManager.NOT_CONNECTED    ] = [ @connect ]
