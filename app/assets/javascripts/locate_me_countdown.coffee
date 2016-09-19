class @LocateMeCountdown
  constructor: (seconds) ->
    @seconds = seconds
    @timers  = []

  setListener: (listener) =>
    @listener = listener

  start: =>
    this.stop()
    @i = @seconds
    for i in [0..@seconds]
      @timers.push setTimeout(this._onTimer, 1000 * i)

  stop: =>
    for timer in @timers
      clearTimeout timer
    @timers = []

  _onTimer: =>
    @listener.locatingIn @i--
