class @TorchNotesPlayer
  constructor: (listener, torchNotes, doneDelay) ->
    @listener = listener
    @torchNotes = torchNotes
    @doneDelay  = doneDelay
    @timers     = []

  setListener: (listener) =>
    @listener = listener
    return this

  start: =>
    offset = 0
    for torchNote in @torchNotes
      this._schedule this._callback(torchNote), offset
      offset += torchNote.duration
    this._schedule @listener.setTorchOff, offset
    this._schedule @listener.done, offset + @doneDelay

  stop: =>
    for timer in @timers
      clearTimeout timer
    @listener.setTorchOff()

  _schedule: (callback, delay) =>
    @timers.push setTimeout(callback, delay)

  _callback: (torchNote) =>
    if torchNote['torch-state'].localeCompare('ON') == 0
      return @listener.setTorchOn
    else
      return @listener.setTorchOff
