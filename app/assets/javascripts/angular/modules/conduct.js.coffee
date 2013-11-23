@Conduct = angular.module('Conduct', ['ngResource'])

@Conduct.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
  $httpProvider.defaults.headers.common['Accept'] = "application/json"
]
