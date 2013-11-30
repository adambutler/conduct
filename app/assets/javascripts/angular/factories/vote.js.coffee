@Conduct.factory 'Vote', ($resource) ->
  class Vote
    constructor: (id) ->
      @service = $resource "/votes/:id.json",
        id: id
      ,
        'update': method: 'PUT'

    create: (attrs, callback) ->
      new @service(vote: attrs).$save (vote) ->
        callback(vote)

    all: ->
      @service.query()

    get: ->
      @service.get()
