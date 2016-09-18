class @TorchNotesPlayerBuilder
  constructor: (doneDelay) ->
    @doneDelay = doneDelay

  setListener: (listener) =>
    @listener = listener

  build: (torchNotes) =>
    return new TorchNotesPlayer @listener, torchNotes, @doneDelay
