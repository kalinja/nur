class TestResultController
  constructor: (@$log, @TestService, @$routeParams, @$scope, @$location, @ResultService) ->
    @$log.debug "constructing TestResultController with @$routeParams.currentTest: #{@$routeParams.currentTest}"
    if (@$routeParams.currentTest)
      @test = @TestService.getTest(@$routeParams.currentTest)
    else
      @test = @TestService.getTest("nazev-testovaciho-testu")

    @loc = @$location
    @answers = @ResultService.getData()
    @showCorrect = @ResultService.showAllCorrect()
    if(@answers == undefined)
      @answers = new Array(@test.questions.length)
    @correctCount = @countCorrect()
    @$log.debug @answers

  answerLetter: (i) ->
    String.fromCharCode((i%26)+97)

  percent: () ->
    Math.round(@correctCount/@test.questions.length*100)

  countCorrect: () ->
    correct = 0
    for i in [0..@test.questions.length-1]
      if(@isCorrect(i))
        correct++
    return correct

  isCorrect: (questionIndex) ->
    if @showCorrect
      return true
    if(@answers[questionIndex] == undefined)
      return false
    if(@test.questions[questionIndex].type == "open-answer")
      return (@test.questions[questionIndex].answer == @answers[questionIndex].value)
    else if(@test.questions[questionIndex].type == "list-select")
      if(@answers[questionIndex].value == undefined)
        idx = -1
      else
        idx = parseInt(@answers[questionIndex].value)
      return (idx >= 0 && @test.questions[questionIndex].answers[idx].correct == true)
    else if(@test.questions[questionIndex].type == "simple-select")
      if(@answers[questionIndex].value == undefined)
        idx = -1
      else
        idx = parseInt(@answers[questionIndex].value)
      return (idx >= 0 && @test.questions[questionIndex].answers[idx].correct == true)
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
    else if(@test.questions[questionIndex].type == "simple-select")
      if(@isCorrect(questionIndex) && answeri==parseInt(@answers[questionIndex].value))
        return "correct"
      else if(!@isCorrect(questionIndex) && @test.questions[questionIndex].answers[answeri].correct)
        return "incorrect"
    else if(@test.questions[questionIndex].type == "multi-select")
      if(@test.questions[questionIndex].answers[answeri].correct==false && (@answers[questionIndex] == undefined || undefined==@answers[questionIndex].values[answeri] || false==@answers[questionIndex].values[answeri]))
        return "correct"
      if(@answers[questionIndex] != undefined && undefined!=@answers[questionIndex].values[answeri] && @test.questions[questionIndex].answers[answeri].correct==@answers[questionIndex].values[answeri])
        return "correct"
      else
        return "incorrect"
    return ""

  correctAnswerText: (questionIndex) ->
    for answer in @test.questions[questionIndex].answers
      if(answer.correct == true)
        return answer.text

  closeTest: () ->
    @loc.path("/")

  repeatTest: () ->
    @loc.search('test', @test.name ).path("testPage")

  showTestRater: ()->
    BootstrapDialog.show(
      {
        message: "<div style='margin-bottom: 20px;'>Ohodnoťte tento test. Vaše hodnocení pomůže dalším uživatelům.</div><div class='row'><div class='col-md-3 text-right'>Hodnocení: 0%</div><div class='col-md-6'><input type=range min=0 max=10 value=10 step=1></div><div class='col-md-3'>100%</div></div>"

        onhide: (dialogRef) ->
        title: "Hodnocení testu"
        type: "type-default"
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

  like: ()->
    if($('#likebtn').hasClass('btn-primary'))
      $('#likebtn').removeClass('btn-primary')
    else
      $('#likebtn').addClass('btn-primary')
      if($('#dislikebtn').hasClass('btn-primary'))
        $('#dislikebtn').removeClass('btn-primary')

  dislike: ()->
    if($('#dislikebtn').hasClass('btn-primary'))
      $('#dislikebtn').removeClass('btn-primary')
    else
      $('#dislikebtn').addClass('btn-primary')
      if($('#likebtn').hasClass('btn-primary'))
        $('#likebtn').removeClass('btn-primary')

  showQuestionReport: ()->
    BootstrapDialog.show(
      {
        message: "<div style='margin-bottom: 20px;'>Co je podle vás s otázkou špatně?</div><div class='row'><div class='col-md-12'><textarea class='form-control description-input' rows='3'></textarea></div></div>"

        onhide: (dialogRef) ->
        title: "Nahlášení otázky"
        type: "type-default"
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
