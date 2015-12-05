class TestEditController
  constructor: (@$log, @TestService, @$routeParams, @$scope) ->
    @$log.debug "constructing TestEditController"
    if (@$routeParams.currentTest)
      @test = @TestService.getTest(@$routeParams.currentTest)
    else
      #@test = @TestService.newTest()
      @test = @TestService.getTest("nazev-testovaciho-testu")
    @difficulties = @TestService.getDifficulties()
    @selectedDifficulty = @getSelectedDifficulty()
    @questionTypes = @TestService.getQuestionTypes()
    @updatePasswordButtonText()

  updateDifficulty: () ->
    index = 0
    for diff in @TestService.getDifficulties()
      index++
      if diff == @selectedDifficulty
        @test.difficultty = index

  getSelectedDifficulty: () ->
    @TestService.getDifficulties()[@test.difficulty - 1]

  addQuestion: (selType) ->
    @test.questions.push({
      "type": selType,
      answers: []
    })

  removeQuestion: (question) ->
    @test.questions.splice(@test.questions.indexOf(question), 1)

  addAnswer: (question) ->
    idx = @test.questions.indexOf(question)
    switch @test.questions[idx].type
      when "simple-select" then @test.questions[idx].answers.push({ correct: false, text: "" })

  removeAnswer: (question, answer) ->
    answers = @test.questions[@test.questions.indexOf(question)].answers
    answers.splice(answers.indexOf(answer), 1)

  toDashedName: (name) ->
    removeDiacritics(nameto.LowerCase()).replace(/\W+/g, " ").replace(/\s+/g, '-')

  passwordButtonClick: () ->
    myTest = @test
    me = this
    scope = @$scope
    if @test.password == null
      BootstrapDialog.show(
        {
          message: 'Your most favorite fruit: <input type="text" class="form-control">'

          onhide: (dialogRef) ->

          buttons: [{
                      label: 'Nastavit heslo',
                      action: (dialogRef) ->
                        myTest.password = dialogRef.getModalBody().find('input').val()
                        me.updatePasswordButtonText()
                        scope.$apply()
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
    else
      myTest.password = null
      @updatePasswordButtonText()

  updatePasswordButtonText: () ->
    if @test.password == null
      @passwordButtonText = "Nastavit heslo"
    else
      @passwordButtonText = "Zrušit heslo"

controllersModule.controller('TestEditController', TestEditController)
