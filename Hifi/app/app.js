'use strict';

// Declare app level module which depends on views, and components
angular.module('Selftest', [
  'ngRoute',
  'ngTagsInput',
  'Selftest.view1',
  'Selftest.version'
]).
config(['$routeProvider', function($routeProvider) {
  $routeProvider.otherwise({redirectTo: '/view1'});
}]);
