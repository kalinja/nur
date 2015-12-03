class TestPageController
  constructor: (@$log, @TestService, @$routeParams, @$scope) ->
    @$log.debug "constructing TestPageController"

controllersModule.controller('TestPageController', TestPageController)
