class @ViewManager
  @EMPTY             = 0
  @WAITING_TO_START  = 1
  @STARTING_IN       = 2
  @TORCH_OFF         = 3
  @TORCH_ON          = 4
  @DONE              = 5
  @READY_TO_LOCATE   = 6
  @FOUND             = 7
  @NOT_FOUND         = 8
  @NO_SHOW           = 9
  @JOINABLE          = 10

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
    @startingIn.html seconds

  _getElement: (jqueryId) =>
    element = $(jqueryId)
    @elements.push element
    return element

  _hideAll: =>
    for element in @elements
      element.hide()

  _initElements: =>
    @noShow          = this._getElement '.info#no-show'
    @waitingToStart  = this._getElement '.info#waiting-to-start'
    @startingIn      = this._getElement '.info#starting-in'
    @done            = this._getElement '.info#done'
    @found           = this._getElement '.info#found'
    @notFound        = this._getElement '.info#not-found'
    @turnPhoneAround = this._getElement '.info#turn-phone-around'
    @torchOn         = this._getElement '.fullscreen#torch-on'
    @torchOff        = this._getElement '.fullscreen#torch-off'
    @join            = this._getElement '.action#join'
    @leave           = this._getElement '.action#leave'
    @locateMe        = this._getElement '.action#locate-me'

  _initStateViews: =>
    @stateViews[ViewManager.EMPTY            ] = []
    @stateViews[ViewManager.WAITING_TO_START ] = [ @waitingToStart, @leave ]
    @stateViews[ViewManager.STARTING_IN      ] = [ @startingIn, @turnPhoneAround, @leave ]
    @stateViews[ViewManager.TORCH_OFF        ] = [ @torchOff ]
    @stateViews[ViewManager.TORCH_ON         ] = [ @torchOn ]
    @stateViews[ViewManager.DONE             ] = [ @done, @leave ]
    @stateViews[ViewManager.READY_TO_LOCATE  ] = [ @locateMe, @leave ]
    @stateViews[ViewManager.FOUND            ] = [ @found, @leave ]
    @stateViews[ViewManager.NOT_FOUND        ] = [ @notFound, @locateMe, @leave ]
    @stateViews[ViewManager.NO_SHOW          ] = [ @noShow ]
    @stateViews[ViewManager.JOINABLE         ] = [ @join ]
