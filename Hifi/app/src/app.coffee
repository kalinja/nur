dependencies = [
  'ngRoute',
  'ngTagsInput',
  'Selftest.view1',
  'Selftest.header',
  'Selftest.version',
  'ui.bootstrap'
]

app = angular.module('Selftest', dependencies)
  .config ($routeProvider) ->
    $routeProvider.otherwise({redirectTo: '/view1'})
