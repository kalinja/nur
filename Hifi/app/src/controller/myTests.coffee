class MyTestListController
  constructor: (@$log, @TestService, @$routeParams, @$scope, @$location) ->
    @$log.debug "constructing MyTestListController"
    @tests = @getSampleTests()
    @runBtnText = "Spustit"
    @editBtnText = "Editovat"
    @deleteBtnText = "Smazat"

  runTest: (test) ->
    @$log.debug "Run test " + test.name
    window.location.href = "#/testPage"

  editTest: (test) ->
    @$log.debug "Edit test " + test.name
    @$location.search('currentTest', 'nazev-testovaciho-testu' ).path("testEdit")

  deleteTest: (index) ->
    tests = @tests
    scope = @$scope
    BootstrapDialog.show({
      title: 'Warning'
      type: "type-default"
      message: 'Opravdu chcete smazat tento test?'
      buttons: [{
        label: 'Ano',
        action: (dialogRef) ->
          tests.splice(index, 1)
          dialogRef.close()
          scope.$apply()
      },
        {
          label: 'Ne',
          action: (dialogRef) ->
            dialogRef.close()
        }
      ]
    })

  getSampleTests: () ->
    @$log.debug "calling get sample tests"
    @TestService.getTests()

controllersModule.controller('MyTestListController', MyTestListController)
