class TestService
  constructor: (@$log, @$http, @$q) ->
    @$log.debug "constructing TestService"
    @tests = @getTempTest()

  getTempTest: () ->
    [
      {
        author: "admin",
        id: "nazev-testovaciho-testu"
        name: "Název testovacího testu",
        description: "Popis testovacího testu.",
        public: true,
        password: null,
        difficulty: 3,
        questions:
          [
            {
              type: "simple-select",
              text: "Kolik je 1 + 1?",
              answers:
                [
                  {
                    correct: true,
                    text: "2",
                  },
                  {
                    correct: false,
                    text: "žirafa",
                  },
                  {
                    correct: false,
                    text: "c",
                  },
                ]
            }
            ,
            {
            type: "list-select",
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
              answers:
                [
                  {
                    correct: true,
                    text: "42",
                  }
                ]
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

  numToDifficulty: () ->


  getTests: () ->
    @$log.debug "getTests()"
    @tests

  getTest: (id) ->
    @$log.log("Hello")
    for test in @tests
      if test.id == id
        return test
    null


servicesModule.service('TestService', TestService)
