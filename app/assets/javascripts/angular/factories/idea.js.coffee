@Conduct.factory 'Idea', ($resource) ->
  class Idea
    constructor: (topic, id) ->
      @service = $resource "/api/v1/topics/:topic/ideas/:id.json",
        id: id
        topic: topic
      ,
        'update': method: 'PUT'

    create: (attrs, callback) ->
      new @service(idea: attrs).$save (idea) ->
        callback(idea)

    all: ->
      @service.query()

    get: ->
      @service.get()
