class TestService
  constructor: (@$log, @$http, @$q) ->
    @$log.debug "constructing TestService"
    @tests = @clone(@getTempTest())

  clone: (obj) ->
    JSON.parse(JSON.stringify(obj))

  getTempTest: () ->
    [
      {
        author: "admin"
        id: "nazev-testovaciho-testu"
        name: "Název testovacího testu"
        description: "Popis testovacího testu."
        public: true
        password: null
        difficulty: 3
        tags:
          [
            "testovaci",
            "test",
            "uzasny",
            "nejlepsi",
            "proste bozi"
          ]
        questions:
          [
            {
              type: "simple-select"
              text: "Kolik je 1 + 1?"
              answers:
                [
                  {
                    correct: true
                    text: "2"
                  },
                  {
                    correct: false
                    text: "žirafa"
                  },
                  {
                    correct: false
                    text: "c"
                  },
                ]
            }
            ,
            {
            type: "simple-select",
            text: "Hlavní město ČR?",
            answers:
              [
                {
                  correct: true,
                  text: "Praha",
                },
                {
                  correct: false,
                  text: "Brno",
                },
                {
                  correct: false,
                  text: "Ostrava",
                },
              ]
          }
          ,
            {
              type: "multi-select",
              text: "NPC problém je?",
              answers:
                [
                  {
                    correct: true,
                    text: "Podmnožina NPH",
                  },
                  {
                    correct: true,
                    text: "podmnožina NP",
                  },
                  {
                    correct: false,
                    text: "podmonožina N",
                  },
                ]
            }
            ,
            {
              type: "open-answer",
              text: "Co je smyslem života?",
              answer: "42"
            }
          ]
      }
    ]

  newTest: () ->
    {
      author: "",
      name: "",
      description: "",
      public: true,
      password: null,
      difficulty: 3,
      questions: []
    }

  getQuestionTypes: () ->
    [
      {
        "type": "simple-select",
        "name": "Výběr jedné správné odpovědi"
      },
      #{
       # "type": "list-select",
       # "name": "Výběr jedné správné odpovědi ze seznamu"
      #},
      {
        "type": "multi-select",
        "name": "Výběr několika správných odpovědí"
      },
      {
        "type": "open-answer",
        "name": "Otázka s otevřenou odpovědí"
      }
    ]

  getTests: () ->
    copyOfTests = []
    for i in @tests
      copyOfTests.push @clone(i)
    copyOfTests

  getTest: (id) ->
    @$log.log("get test id: #{id}")
    for test in @tests
      if test.id.localeCompare(id) == 0
        @$log.log("returning existing test")
        return @clone(test)
    @$log.log("Creating new test")
    @newTest()

  getTestNoClone: (id) ->
    @$log.log("Hello")
    for test in @tests
      if test.id.localeCompare(id) == 0
        return test
    null

  save: (test) ->
    idx = @tests.indexOf(@getTestNoClone(test.id))
    @$log.log("id: #{test.id} idx: #{idx} @getTestNoClone(test.id): #{@getTestNoClone(test.id)}")
    if idx == -1
      test.id = toDashedName(test.name)
      @$log.log("new id: #{test.id}")
      @tests.push(test)
    else
      @tests[idx] = test

  getDifficulties: () ->
    [
      "Snadný",
      "Mírně obtížný",
      "Středně obtížný",
      "Obtížný",
      "Velmi Obtížný",
    ]

servicesModule.service('TestService', TestService)
