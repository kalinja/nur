'use strict';

view1 = angular.module('Selftest.view1', ['ngRoute', 'ui.bootstrap'])

view1.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.when('/view1',
  {
    templateUrl: '/app/src/view1/view1.html',
    controller: 'View1Ctrl'
  })
])

view1.controller('View1Ctrl',
  ($scope) ->
    $scope.tags = [{
      text: 'just'
    }, {
      text: 'some'
    }, {
      text: 'cool'
    }, {
      text: 'tags'
    }]

    $scope.loadTags = (query) ->
      ["hello"]
);
