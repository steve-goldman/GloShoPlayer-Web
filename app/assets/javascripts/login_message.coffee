class @LoginMessage
  constructor: (playerId) ->
    @playerId = playerId
    @platform = 'WEB'
    @version  = '1'
    # TODO: more stuff here

  generate: =>
    message = new Message 'player-login'
    message.put 'id',       @playerId
    message.put 'platform', @platform
    message.put 'version',  @version
    return message
