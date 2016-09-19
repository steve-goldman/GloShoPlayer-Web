class @DonePlayingNotifier
  constructor: ->
    navigator.vibrate = navigator.vibrate || navigator.webkitVibrate || navigator.mozVibrate || navigator.msVibrate
    if !navigator.vibrate
      console.log 'vibration not supported'
    @beep = $('.audio#beep')[0]

  init: =>
    @beep.load()

  notify: =>
    if navigator.vibrate
      navigator.vibrate 500
    @beep.play()
