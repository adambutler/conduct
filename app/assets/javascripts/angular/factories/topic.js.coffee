@Conduct.factory 'Topic', ($resource) ->
  class Topic
    constructor: ->
      @service = $resource "/topics/:secret.json",
        secret: "@secret"
      ,
        'update': method: 'PUT'

    create: (attrs, callback) ->
      new @service(topic: attrs).$save (topic) ->
        callback(topic)

    all: ->
      @service.query()
