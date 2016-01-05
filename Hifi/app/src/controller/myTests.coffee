class MyTestListController
  constructor: (@$log, @TestService, @$routeParams, @$scope, @$location) ->
    @$log.debug "constructing MyTestListController"
    @tests = @getSampleTests()
    @runBtnText = "Spustit"
    @editBtnText = "Editovat"
    @deleteBtnText = "Smazat"
    location = @$location
    @$scope.$on('filterByTags', (event, args) ->
      location.path('/')
    )

  runTest: (test) ->
    @$location.search('currentTest', test.id ).path("testPage")

  editTest: (test) ->
    @$location.search('currentTest', test.id ).path("testEdit")

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
