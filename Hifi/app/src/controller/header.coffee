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

  loadTags: (query) ->
    ["hello"]

  toggled: (open) ->
    @$log.log('Dropdown is now: ', open);

  toggleDropdown: ($event) ->
    $event.preventDefault();
    $event.stopPropagation();
    @status.isopen = !@status.isopen;

controllersModule.controller('HeaderController', HeaderController)
