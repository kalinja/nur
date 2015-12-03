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
