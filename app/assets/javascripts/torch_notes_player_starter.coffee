class @TorchNotesPlayerStarter
  update: (localStartTime, torchNotesPlayer) =>
    this.close()

    @torchNotesPlayer = torchNotesPlayer

    if localStartTime == 0
      torchNotesPlayer.start()
    else
      now             = Math.round performance.now()
      delay           = localStartTime - now
      @timer          = setTimeout torchNotesPlayer.start, delay
      @localStartTime = localStartTime
      for seconds in [1..Math.floor(delay / 1000)]
        setTimeout this._startingIn, delay - 1000 * seconds

  setListener: (listener) =>
    @listener = listener

  close: =>
    this._cancelTimer()
    this._stopTorchNotesPlayer

  _cancelTimer: =>
    if @timer != null
      clearTimeout @timer
      @timer = null

  _stopTorchNotesPlayer: =>
    if @torchNotesPlayer != null
      @torchNotesPlayer.stop()
      @torchNotesPlayer = null

  _startingIn: =>
    @listener.startingIn Math.round((@localStartTime - performance.now()) / 1000)
