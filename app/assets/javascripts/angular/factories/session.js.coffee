@Conduct.factory 'Session', ["$resource", ($resource) ->
  class Session
    constructor: ->
      @service = $resource "/sessions/:id.json",
        id: "@id"

    create: (attrs, callback, error) ->
      new @service(user: attrs).$save (session) ->
        callback(session)
      , error

    all: ->
      @service.query()
]
