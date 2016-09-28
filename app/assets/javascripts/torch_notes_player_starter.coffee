class @TorchNotesPlayerStarter
  constructor: ->
    @timers = []

  update: (localStartTime, torchNotesPlayer) =>
    this.close()
    @torchNotesPlayer = torchNotesPlayer

    if localStartTime == 0
      torchNotesPlayer.start()
    else
      now             = Math.round performance.now()
      delay           = localStartTime - now
      @localStartTime = localStartTime
      this._schedule torchNotesPlayer.start, delay
      for seconds in [1..Math.floor(delay / 1000)]
        this._schedule this._startingIn, delay - 1000 * seconds

  setListener: (listener) =>
    @listener = listener

  close: =>
    this._cancelTimers()
    this._stopTorchNotesPlayer

  _cancelTimers: =>
    for timer in @timers
      clearTimeout timer
    @timers = []

  _stopTorchNotesPlayer: =>
    if @torchNotesPlayer != null
      @torchNotesPlayer.stop()
      @torchNotesPlayer = null

  _startingIn: =>
    @listener.startingIn Math.round((@localStartTime - performance.now()) / 1000)

  _schedule: (callback, delay) =>
    @timers.push setTimeout(callback, delay)
