'use strict';

angular.module('Selftest.view1', ['ngRoute', 'ui.bootstrap'])

.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/view1', {
    templateUrl: 'view1/view1.html',
    controller: 'View1Ctrl'
  });
}])

.controller('View1Ctrl',
  function($scope) {
    $scope.tags = [{
      text: 'just'
    }, {
      text: 'some'
    }, {
      text: 'cool'
    }, {
      text: 'tags'
    }];

    $scope.loadTags = function(query) {
      return ["hello"];
    };
  }
);
