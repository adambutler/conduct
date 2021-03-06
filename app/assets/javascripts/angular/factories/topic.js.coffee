@Conduct.factory 'Topic', ["$resource", ($resource) ->
  class Topic
    constructor: (secret) ->
      @service = $resource "/api/v1/topics/:secret.json",
        secret: secret || '@secret'
      ,
        'update': method: 'PUT'

    create: (attrs, callback) ->
      new @service(topic: attrs).$save (topic) ->
        callback(topic)

    all: ->
      @service.query()

    get: ->
      @service.get()
]
