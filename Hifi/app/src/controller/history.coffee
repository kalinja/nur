class HistoryController
  constructor: (@$log, @TestService, @$routeParams, @$scope, @$location) ->
    @$log.debug "constructing HistoryController"
    @tests = @getSampleTests()
    @runBtnText = "Spustit"
    @clearAllBtnText = "Smazat celou historii"
    @editBtnText = "Editovat"
    @deleteBtnText = "Smazat"

  clearAllHistory: () ->


  runTest: (test) ->
    @$log.debug "Run test " + test.name
    window.location.href = "#/testPage"

  editTest: (test) ->
    @$log.debug "Edit test " + test.name
    window.location.href = "#/testEdit"

  deleteHistory: (index) ->
    tests = @tests
    scope = @$scope
    BootstrapDialog.show({
      title: 'Warning'
      message: 'Opravdu chcete smazat historii tohoto testu?'
      buttons: [{
        label: 'Ano',
        action: (dialogRef) ->
          tests[index].rating = 0
          tests[index].runCount = 0
          tests[index].maxScore = 0
          tests[index].lastScore = 0
          tests[index].noHistory = true
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
    [
      {
        "name": "Test 1"
        "description": "Test 1 awesome description is here!!"
        "collapsed": false
        "rating": 30
        "runCount": 25
        "maxScore": 85
        "lastScore": 50
        "noHistory": false
      },
      {
        "name": "Test 2"
        "description": "Test 2 awesome description is here!!"
        "collapsed": true
        "rating": 50
        "runCount": 25
        "maxScore": 85
        "lastScore": 50
        "noHistory": false
      },
      {
        "name": "Test 3"
        "description": "Test 3 awesome description is here!!"
        "collapsed": true
        "rating": 70
        "runCount": 25
        "maxScore": 85
        "lastScore": 50
        "noHistory": true
      },
      {
        "name": "Test 4"
        "description": "Test 4 awesome description is here!!"
        "collapsed": true
        "rating": 100
        "runCount": 25
        "maxScore": 85
        "lastScore": 50
        "noHistory": false
      }
    ]

controllersModule.controller('HistoryController', HistoryController)
