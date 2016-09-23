class @ClickListener
  setListener: (listener) =>
    @listener = listener
    $('.action#join').click      => @listener.join()
    $('.action#leave').click     => @listener.leave()
    $('.action#locate-me').click => @listener.locateMe()
