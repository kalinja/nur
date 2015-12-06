class ResultService
  constructor: (@$log, @$http, @$q) ->
    @$log.debug "constructing ResultService"
    @showCorrect = false

  setData: (data)->
    @data = data

  getData: () ->
    @data

  makeShowCorrect: () ->
    @showCorrect = true

  showAllCorrect: () ->
    @showCorrect

servicesModule.service('ResultService', ResultService)