class TestEditController
  constructor: (@$log, @TestService, @$routeParams, @$location, @$scope) ->
    @$log.debug "constructing TestEditController"
    @hiddenAnswers = []
    if (@$routeParams.currentTest)
      @test = @TestService.getTest(@$routeParams.currentTest)
    else
      @test = @TestService.newTest()
      #@test = @TestService.getTest("nazev-testovaciho-testu")
    @difficulties = @TestService.getDifficulties()
    @selectedDifficulty = @getSelectedDifficulty()
    @questionTypes = @TestService.getQuestionTypes()
    @updatePasswordButtonText()
    @registerOnEvents()
    @updateHiddenAnswers()

  getQuestionTypeName: (type) ->
    for qType in @questionTypes
      if qType.type.localeCompare(type) == 0
        return qType.name
    return "Chyba"

  registerOnEvents: () ->
    thiz = this
    @$scope.test = @test
    @$scope.$on("$destroy", (event, args) ->
      thiz.$scope.$emit("testBeingEditedStop", null)
    )
    @$scope.$on("saveTest", (event, args) ->
      thiz.save()
    )
    @$scope.$watch("test", () ->
        thiz.onChange()
      , true)
    location = @$location
    @$scope.$on('filterByTags', (event, args) ->
      location.path('/')
    )

  onChange: () ->
    @$scope.$emit("testChanged", null)

  save: () ->
    @TestService.save(@test)
    @onSaved()

  onSaved: () ->
    @$scope.$emit("testSaved", null)

  onInit: () ->
    @$log.debug "emitting"
    @$scope.$emit("testBeingEdited", null)

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
    @updateHiddenAnswers()

  removeQuestion: (question) ->
    @test.questions.splice(@test.questions.indexOf(question), 1)
    @updateHiddenAnswers()

  addAnswer: (question) ->
    idx = @test.questions.indexOf(question)
    switch @test.questions[idx].type
      when "simple-select" then @addSimpleAnswer(idx)
      when "list-select" then @addSimpleAnswer(idx)
      when "multi-select" then @addSimpleAnswer(idx)

  addSimpleAnswer: (idx) ->
    newAnswer = { "correct": false, "text": "" }
    if @test.questions[idx].answers.length == 0
      newAnswer.correct = true
    @$log.debug "newAnswer[correct]: #{newAnswer["correct"]}"
    @test.questions[idx].answers.push(newAnswer)

  removeAnswer: (question, answer) ->
    answers = @test.questions[@test.questions.indexOf(question)].answers
    answers.splice(answers.indexOf(answer), 1)

  passwordButtonClick: () ->
    myTest = @test
    me = this
    scope = @$scope
    if @test.password == null
      BootstrapDialog.show(
        {
          message: '<label>Zvolte heslo: <input type="password" class="form-control"> </label>'
          onhide: (dialogRef) ->

          type: "type-default"
          title: 'Nastavení hesla testu'
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

  checkTest: (test) ->
    error = false
    errorMsgPre = "Nedokončený test:\n"
    errorMsg = ""
    if test.name is undefined or test.name.length < 1
      error = true
      errorMsg += "Prázdné jméno testu!\n"
    if test.questions.length < 1
      error = true
      errorMsg += "Žádná otázka!\n"
    for question in test.questions
      @$log.debug "check question text: #{question.text}"
      if question.text is undefined or question.text.length < 1
        error = true
        errorMsg += "Otázka bez textu!\n"
      @$log.debug "check question.answers: #{question.answers}"
      if question.answers
        if question.answers.length < 1
          error = true
          errorMsg += "Otázka bez odpovědí!\n"
        correct = false
        for answer in question.answers
          @$log.debug "check answer text: #{answer.text}"
          @$log.debug "check answer correct: #{answer.correct}"
          if answer.correct
            correct = true
          if answer.text is undefined or answer.text.length < 1
            error = true
            errorMsg += "Prázdná odpověď!\n"
        if not correct
          error = true
          errorMsg += "Žádná správná odpověd!\n"
    if error
      window.alert(errorMsgPre + errorMsg)
    not error

  saveAndFinish: () ->
    if @checkTest(@test)
      tags = []
      for tag in @test.tags
        if typeof tag is 'string'
          tags.push(tag)
        else
          if tag["text"] != null
            tags.push(tag["text"])
      @test.tags = tags
      @$log.debug "@test.tags: #{@test.tags}"
      @TestService.save(@test)
      @$location.path("/myTests")


  toggleRadio: (question, answer) ->
    for otherAnswer in question.answers
      if otherAnswer.correct
        otherAnswer.correct = false
    answer.correct = true

  toggleCheckBox: (question, answer) ->
    answer.correct = !answer.correct

  updateHiddenAnswers: () ->
    @hiddenAnswers.splice(0,@hiddenAnswers.length)
    idx = 0
    for question in @test.questions
      if question.type == "open-answer"
        @hiddenAnswers[idx] =
        {
          "visibility": "hidden"
        }
      else
        { }
      idx++

controllersModule.controller('TestEditController', TestEditController)
