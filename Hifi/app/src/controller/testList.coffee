class TestListController
  constructor: (@$log, @TestService, @$routeParams, @$scope, @ResultService, @$location) ->
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

  updateByTags: (tagsSrc) ->
    @$log.debug "updateByTags"
    @tests.length = 0
    tags = []
    for tag in tagsSrc
      if typeof tag is 'string'
        tags.push(tag)
      else
        if tag["text"] != null
          tags.push(tag["text"])
    for test in @TestService.getTests()
      foundAll = true
      for tagSearch in tags
        found = false
        for tag in test.tags
          if toDashedName(tag).localeCompare(toDashedName(tagSearch)) == 0
            found = true
            break
        foundAll = foundAll and found
      if foundAll
        @tests.push(test)

  runTest: (test) ->
    @$location.search('currentTest', test.id ).path("testPage")

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
