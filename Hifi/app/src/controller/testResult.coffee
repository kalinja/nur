class TestResultController
  constructor: (@$log, @TestService, @$routeParams, @$scope, @$location, @ResultService) ->
    @$log.debug "constructing TestResultController"
    if (@$routeParams.currentTest)
      @test = @TestService.getTest(@$routeParams.test)
    else
      @test = @TestService.getTest("nazev-testovaciho-testu")

    @loc = @$location
    @answers = @ResultService.getData()
    if(@answers == undefined)
      @answers = new Array(@test.questions.length)
    @correctCount = @countCorrect()
    @$log.debug @answers

  answerLetter: (i) ->
    String.fromCharCode((i%26)+97)

  countCorrect: () ->
    correct = 0
    for i in [0..@test.questions.length-1]
      if(@isCorrect(i))
        correct++
    return correct

  isCorrect: (questionIndex) ->
    if(@answers[questionIndex] == undefined)
      return false
    if(@test.questions[questionIndex].type == "open-answer")
      return (@test.questions[questionIndex].answer == @answers[questionIndex].value)
    else if(@test.questions[questionIndex].type == "list-select")
      idx = parseInt(@answers[questionIndex].value)
      return (idx >= 0 && @test.questions[questionIndex].answers[idx].correct == true)
    else if(@test.questions[questionIndex].type == "simple-select")
      idx = parseInt(@answers[questionIndex].value)
      return @test.questions[questionIndex].answers[idx].correct == true
    else if(@test.questions[questionIndex].type == "multi-select")
      for i in [0..@test.questions[questionIndex].answers.length-1]
        if(@answers[questionIndex].values[i] == undefined && @test.questions[questionIndex].answers[i].correct)
          return false
        else if(@answers[questionIndex].values[i] == false && @test.questions[questionIndex].answers[i].correct == true)
          return false
        else if(@answers[questionIndex].values[i] == true && @test.questions[questionIndex].answers[i].correct == false)
          return false
      return true



  style: (questionIndex, answeri=0) ->
    if(@test.questions[questionIndex].type == "open-answer" || @test.questions[questionIndex].type == "list-select")
      if(@isCorrect(questionIndex))
        return "correct"
      else
        return "incorrect"

    return ""

  closeTest: () ->
    @loc.path("/")

  repeatTest: () ->
    @loc.search('test', @test.name ).path("testPage")

  showTestRater: ()->
    BootstrapDialog.show(
      {
        message: "Ohodnoťte tento test. Vaše hodnocení pomůže dalším uživatelům."

        onhide: (dialogRef) ->

        buttons: [{
          label: 'Odeslat',
          action: (dialogRef) ->
            dialogRef.close()
        },
          {
            label: 'Zrušit',
            action: (dialogRef) ->
              dialogRef.close()
          }
        ]
      }
    )

controllersModule.controller('TestResultController', TestResultController)