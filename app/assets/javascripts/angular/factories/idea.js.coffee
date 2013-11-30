@Conduct.factory 'Idea', ($resource) ->
  class Idea
    constructor: (id) ->
      @service = $resource "/ideas/:id.json",
        id: id
      ,
        'update': method: 'PUT'

    create: (attrs, callback) ->
      new @service(idea: attrs).$save (idea) ->
        callback(idea)

    all: ->
      @service.query()

    get: ->
      @service.get()
