class TestListController
  constructor: (@$log, @TestService, @$routeParams, @$scope, @ResultService) ->
    @$log.debug "constructing TestListController"
    @tests = @TestService.getTests()
    @runBtnText = "Spustit"
    @ResultService.clear()
    @registerOnEvents()

  registerOnEvents: () ->
    thiz = this
    @$scope.$on('filterByTags', (event, args) ->
      thiz.updateByTags(args)
    )

  updateByTags: (tags) ->
    @$log.debug "updateByTags"
    @tests.length = 0
    for test in @TestService.getTests()
      @$log.debug "tags.length: #{tags.length}"
      found = tags.length == 0
      for tag in test.tags
        for tagSearch in tags
          if toDashedName(tag).localeCompare(toDashedName(tagSearch["text"])) == 0
            found = true
            break
      if found
        @tests.push(test)

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
