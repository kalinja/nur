class TestPageController
  constructor: (@$log, @TestService, @$routeParams, @$scope, @$location) ->
    @$log.debug "constructing TestPageController"
    if (@$routeParams.currentTest)
      @test = @TestService.getTest(@$routeParams.currentTest)
    else
      @test = @TestService.getTest("nazev-testovaciho-testu")
    @completed = 40

    @answers = new Array()

  answerLetter: (i) ->
    String.fromCharCode((i%26)+97)

  submit: () ->
    console.log('Value',@answers)



controllersModule.controller('TestPageController', TestPageController)
