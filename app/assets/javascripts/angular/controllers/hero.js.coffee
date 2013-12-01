@HeroController = ["$scope", "$timeout", "Topic", "Session", ($scope, $timeout, Topic, Session) ->

  $scope.options =
    host: "http://conduct.io"
    defaults:
      topic:
        title: "Subject for next weeks meetup"

  $scope.waitingForResource = false

  $scope.topic = {}
  $scope.user = {}

  $scope.construct = (options, user_id) ->
    $.extend $scope.options, options
    $scope.user.id = user_id

    console.log "Logged in as user #{user_id}"

  $scope.getNewTopic = ->
    console.log "getNewTopic"
    new Topic().create {
      title: ""
      user_id: $scope.user.id
    }, (topic) ->
      console.log "New topic created with ID of #{topic.secret}"
      liveTitle = $scope.topic.title
      $scope.topic = topic
      $scope.topic.title = liveTitle

  $scope.getTopicDisplayTitle = ->
    $scope.topic.title || $scope.options.defaults.topic.title

  $scope.getTopicDisplayLink = ->
    if $scope.topic.secret?
      return "#{$scope.options.host}/#{$scope.topic.secret}"
    else
      return ""

  $scope.statusDataRecived = ->
    $scope.topic?.secret?

  $scope.statusUserRecived = ->
    $scope.topic?.user_id?

  $scope.loginFormSubmited = ->
    new Session().create {
      email: $scope.user.email
      password: $scope.user.password
    }, (user) ->
      $scope.topic.user_id = user.id
      $scope.topic.$update()
    , (error) ->
      console.log error
      switch error.status
        when 401 then alert "Sorry the password you entered does not match that e-mail."
        else alert "Oops... Something went wrong and we can't create your user at this time."

  $scope.$watch 'topic.title', ->

    console.log "Watching topic title set to (#{$scope.topic.title})"

    if $scope.statusDataRecived()
      $timeout.cancel($scope.keyDelay) if $scope.keyDelay?
      $scope.keyDelay = $timeout ->
        console.log "Update"
        $scope.keyDelay = undefined
        $scope.topic.$update()
      , 600
    else
      if $scope.freezeGetNewTopic? is false and $scope.topic.title? is true
        console.log $scope.topic.title
        $scope.getNewTopic()
        $scope.freezeGetNewTopic = true
]
