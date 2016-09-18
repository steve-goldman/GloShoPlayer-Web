class @ClickListener
  setListener: (listener) =>
    @listener = listener
    $('.action#connect').click    => @listener.connect()
    $('.action#disconnect').click => @listener.disconnect()
    $('.action#locate-me').click  => @listener.locateMe()
