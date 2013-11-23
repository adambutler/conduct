@TopicController = ["$scope", "$timeout", "Topic", ($scope, $timeout, Topic) ->

  $scope.options = {}

  $scope.construct = (options, topic_secret) ->
    $.extend $scope.options, options

    console.log "Query Topic #{topic_secret}"

    $scope.topic = new Topic(topic_secret).get()
]
