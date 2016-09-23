class @WebSocketWrapperBuilder
  build: (serverUrl) =>
    playerId = this._getPlayerId()
    return new WebSocketWrapper playerId, serverUrl

  _getPlayerId: =>
    playerId = Cookies.get 'player_id'
    if !playerId
      playerId = this._generatePlayerId()
      Cookies.set 'player_id', playerId, { expires: this._getExpireTime() }
    return playerId

  _generatePlayerId: =>
    return (Math.random() + 1).toString(36).slice(2)

  _getExpireTime: =>
    return new Date(new Date().getTime() + 60 * 60 * 1000)
