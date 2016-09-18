class @TorchNotesPlayerStarter
  update: (localStartTime, torchNotesPlayer) =>
    this.close()

    @torchNotesPlayer = torchNotesPlayer

    if localStartTime == 0
      torchNotesPlayer.start()
    else
      delay  = localStartTime - (new Date().getTime())
      @timer = setTimeout torchNotesPlayer.start, delay

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
