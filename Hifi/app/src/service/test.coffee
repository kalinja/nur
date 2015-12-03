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
