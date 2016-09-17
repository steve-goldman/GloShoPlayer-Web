class @PlayerBuilder
  build: =>
    viewManager = new ViewManager();
    return new Player viewManager;
