class TestListController
  constructor: (@$log, @TestService, @$routeParams, @$scope, @ResultService) ->
    @$log.debug "constructing TestListController"
    @tests = @getSampleTests()
    @runBtnText = "Spustit"
    @ResultService.clear()

  runTest: (test) ->
    @$log.debug "Run test " + test.name
    window.location.href = "#/testPage"

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

controllersModule.controller('TestListController', TestListController)
