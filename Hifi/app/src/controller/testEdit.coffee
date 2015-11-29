class TestEditController
  constructor: (@$log, @TestService, @$routeParams, @$scope) ->
    @$log.debug "constructing TestEditController"
    if (@$routeParams.currentTest)
      @test = @TestService.getTest(@$routeParams.currentTest)
    else
      #@test = @TestService.newTest()
      @test = @TestService.getTest("nazev-testovaciho-testu")
    @difficulties = @getDifficulties()
    @selectedDifficulty = @getSelectedDifficulty()
    @questionTypes = @getQuestionTypes()

  getDifficulties: () ->
    [
      "Snadný",
      "Mírně obťížný",
      "Středně obťížný",
      "Obťížný",
      "Velmi Obťížný",
    ]

  updateDifficulty: () ->
    index = 0
    for diff in @getDifficulties()
      index++
      if diff == @selectedDifficulty
        @test.difficultty = index

  getSelectedDifficulty: () ->
    @getDifficulties()[@test.difficulty - 1]

  getQuestionTypes: () ->
    [
      {
        "type": "simple-select",
        "name": "Výběr jedné správné odpovědi"
      }
    ]

  addQuestion: (selType) ->
    @test.questions.push({
      "type": selType,
      answers: []
    })

  removeQuestion: (questionIndex) ->
    @test.questions.splice(questionIndex, 1)

  addAnswer: (questionIndex) ->
    switch @test.questions[questionIndex].type
      when "simple-select" then @test.questions[questionIndex].answers.push({ correct: false, text: "" })

  removeAnswer: (qIndex, aIndex) ->
    @test.questions[qIndex].answers.splice(aIndex, 1);

  toDashedName: (name) ->
    removeDiacritics(nameto.LowerCase()).replace(/\W+/g, " ").replace(/\s+/g, '-')

controllersModule.controller('TestEditController', TestEditController)
