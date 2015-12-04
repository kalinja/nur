class TestPageController
  constructor: (@$log, @TestService, @$routeParams, @$scope) ->
    @$log.debug "constructing TestPageController"
    if (@$routeParams.currentTest)
      @test = @TestService.getTest(@$routeParams.currentTest)
    else
      @test = @TestService.getTest("nazev-testovaciho-testu")
    @completed = 40

  answerLetter: (i) ->
    String.fromCharCode((i%26)+97)


controllersModule.controller('TestPageController', TestPageController)
