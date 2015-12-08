class TestPageController
  constructor: (@$log, @TestService, @$routeParams, @$scope, @$location, @ResultService) ->
    @$log.debug "constructing TestPageController"
    if (@$routeParams.currentTest)
      @test = @TestService.getTest(@$routeParams.currentTest)
    else
      @test = @TestService.getTest("nazev-testovaciho-testu")
    @completed = 40
    thiz = this
    @loc = @$location
    @answers = new Array()
    @$scope.answers = @answers
    console.log('Value',@answers.length)
    @res = @ResultService
    location = @$location
    @$scope.$on('filterByTags', (event, args) ->
      location.path('/')
    )

  answerLetter: (i) ->
    String.fromCharCode((i%26)+97)

  submit: () ->
    @res.setData(@answers)
    console.log('Value',@answers)
    @loc.path('/testResult')

  countAnswers: () ->
    console.log('Tick')
    console.log('Value',@answers)
    val = @answers.length/@test.questions.length*100
    $('.progress-bar').css('width', val+'%').attr('aria-valuenow', val);
    return true




controllersModule.controller('TestPageController', TestPageController)
