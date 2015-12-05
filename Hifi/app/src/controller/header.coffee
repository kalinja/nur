class HeaderController
  constructor: (@$log, @TestService, @$routeParams, @$scope) ->
      @$log.debug "constructing HeaderController"
      @tags = [{
        text: 'just'
      }, {
        text: 'some'
      }, {
        text: 'cool'
      }, {
        text: 'tags'
      }]
      @items = [
        'The first choice!',
        'And another choice for you.',
        'but wait! A third!'
      ]
      @status = isopen: false
      @saveButtonEnabled = false
      @saveButtonSaved = false
      @updateSaveButtonText()
      @registerOnEvents()

  registerOnEvents: () ->
    thiz = this
    @$scope.$on('testSaved', (event, args) ->
      thiz.saveButtonSaved = true
      thiz.updateSaveButtonText()
      )
    @$scope.$on('testChanged', (event, args) ->
      thiz.saveButtonSaved = false
      thiz.updateSaveButtonText()
      )
    @$scope.$on('testBeingEdited', (event, args) ->
      thiz.$log.debug("testBeingEdited event arrived")
      thiz.saveButtonEnabled = true
      )
    @$scope.$on('testBeingEditedStop', (event, args) ->
      thiz.saveButtonEnabled = false
      )

  updateSaveButtonText: () ->
    if @saveButtonSaved
      @saveButtonText = "Uloženo"
    else
      @saveButtonText = "Uložit"

  loadTags: (query) ->
    ["hello"]

  toggled: (open) ->
    @$log.log('Dropdown is now: ', open);

  toggleDropdown: ($event) ->
    $event.preventDefault();
    $event.stopPropagation();
    @status.isopen = !@status.isopen;

controllersModule.controller('HeaderController', HeaderController)
