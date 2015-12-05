class TestResultController
  constructor: (@$log, @TestService, @$routeParams, @$scope, @$location, @ResultService) ->
    @$log.debug "constructing TestResultController"
    if (@$routeParams.currentTest)
      @test = @TestService.getTest(@$routeParams.test)
    else
      @test = @TestService.getTest("nazev-testovaciho-testu")

    @loc = @$location
    @answers = @ResultService.getData()
    @$log.debug @answers

  answerLetter: (i) ->
    String.fromCharCode((i%26)+97)

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