class @Player
  constructor: (viewManager) ->
    @viewManager = viewManager;

  run: =>
    @viewManager.setViewState ViewManager.NOT_CONNECTED;
