class TestResultController
  constructor: (@$log, @TestService, @$routeParams, @$scope) ->
    @$log.debug "constructing TestResultController"
    if (@$routeParams.currentTest)
      @test = @TestService.getTest(@$routeParams.currentTest)
    else
      @test = @TestService.getTest("nazev-testovaciho-testu")

  answerLetter: (i) ->
    String.fromCharCode((i%26)+97)

controllersModule.controller('TestResultController', TestResultController)