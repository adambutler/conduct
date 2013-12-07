@Conduct.directive "switch", ->
  restrict: "A"

  link: (scope, elm, attrs) ->

    setState = ->
      if scope.on
          scope.state = "switch--on"
        else
          scope.state = "switch--off"

    scope.on = (attrs.state == "true")
    scope.state = "switch--toggle-off"
    setState()

    elm[0].onclick = ->
      scope.$apply ->
        scope.on = !scope.on
        setState()
        

    setTimeout ->
      scope.$apply()
    , 1
