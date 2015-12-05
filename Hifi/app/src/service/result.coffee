class ResultService
  constructor: (@$log, @$http, @$q) ->
    @$log.debug "constructing ResultService"

  setData: (data)->
    @data = data

  getData: () ->
    @data

servicesModule.service('ResultService', ResultService)