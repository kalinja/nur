class TestPageController
  constructor: (@$log, @TestService, @$routeParams, @$scope) ->
    @$log.debug "constructing TestPageController"
    @test = @TestService.getTest("nazev-testovaciho-testu")
    @completed = 40

  answerLetter: (i) ->
    String.fromCharCode((i%26)+97)


controllersModule.controller('TestPageController', TestPageController)
