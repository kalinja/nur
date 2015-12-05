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
    window.location.href = "#/testEdit"

  deleteTest: (index) ->
    tests = @tests
    BootstrapDialog.show({
      title: 'Warning'
      message: 'Opravdu chcete smazat tento test?'
      buttons: [{
        label: 'Ano',
        action: (dialogRef) ->
          tests.splice(index, 1)
          dialogRef.close()
          @$scope.apply()
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
    [
      {
        "name": "Test 1"
        "description": "Test 1 awesome description is here!!"
        "collapsed": false
      },
      {
        "name": "Test 2"
        "description": "Test 2 awesome description is here!!"
        "collapsed": true
      },
      {
        "name": "Test 3"
        "description": "Test 3 awesome description is here!!"
        "collapsed": true
      },
      {
        "name": "Test 4"
        "description": "Test 4 awesome description is here!!"
        "collapsed": true
      }
    ]

controllersModule.controller('MyTestListController', MyTestListController)
