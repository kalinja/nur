class TestPageController
  constructor: (@$log, @TestService, @$routeParams, @$scope) ->
    @$log.debug "constructing TestPageController"
    @test = @TestService.getTest("nazev-testovaciho-testu")
    @completed = 40

controllersModule.controller('TestPageController', TestPageController)
