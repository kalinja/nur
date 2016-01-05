class HeaderController
  constructor: (@$log, @TestService, @$routeParams, @$location, @$scope) ->
      @$log.debug "constructing HeaderController"
      @$scope.tags = []
      @status = isopen: false
      @saveButtonEnabled = false
      @loggedIn = false
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
    @$scope.$watch("tags", () ->
        thiz.onTagsChange()
      , true)

  onTagsChange: () ->
    @$scope.$broadcast("filterByTags", @$scope.tags)

  saveTest: () ->
    @$scope.$broadcast("saveTest", null)

  updateSaveButtonText: () ->
    if @saveButtonSaved
      @saveButtonText = "Uloženo"
    else
      @saveButtonText = "Uložit"

  login: () ->
    @loggedIn = true

  logout: () ->
    @loggedIn = false

  loadTags: (query) ->
    tags = []
    for test in @TestService.getTests()
      for tag in test.tags
        if typeof tag is 'string'
          tags.push(tag)
        else
          @$log.debug("tag:#{tag["text"]}")
          if tag["text"] != null
            tags.push(tag["text"])
    resTags = []
    tags = tags.sort().unique()
    for tag in tags
      if tag.substr(0, query.length).toUpperCase() == query.toUpperCase()
        resTags.push(tag)
    resTags

  toggled: (open) ->
    @$log.log('Dropdown is now: ', open);

  toggleDropdown: ($event) ->
    $event.preventDefault();
    $event.stopPropagation();
    @status.isopen = !@status.isopen;

  newTest: () ->
    @$location.path("/testEdit")

controllersModule.controller('HeaderController', HeaderController)
