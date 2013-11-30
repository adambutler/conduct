@TopicController = ["$scope", "$timeout", "Topic", "Vote", "Idea", ($scope, $timeout, Topic, Vote, Idea) ->

  $scope.options = {}
  $scope.newIdea = {}
  $scope.topic = {}
  $scope.sort = "-votes.total_vote_qty"

  $scope.votable = (idea) ->
    !idea.votes.current_user_vote_id?

  $scope.vote = (idea) ->
    if $scope.votable(idea)
      $scope.newVote(idea)
    else
      alert 'you can only vote once'

  $scope.addIdea = ->
    new Idea().create {
      title: $scope.newIdea.title
      description: $scope.newIdea.description
      topic_id: $scope.topic.secret
    }, (idea) ->
      $scope.topic.ideas.push idea

  $scope.newVote = (idea) ->

    idea.votes.total_vote_qty++

    new Vote().create {
      idea_id: idea.id
    }, (vote) ->
      console.log "New idea created with ID of #{vote.id}"
      idea.votes.current_user_vote_id = vote.id

  $scope.construct = (options, topic_secret) ->
    $.extend $scope.options, options

    $scope.topic.secret = topic_secret

    console.log "Query Topic #{topic_secret}"

    $scope.topic = new Topic(topic_secret).get()
]
