'use strict';

header = angular.module('Selftest.header', [])

header.controller('HeaderCtrl',
  ($scope, $log) ->
    $scope.items = [
      'The first choice!',
      'And another choice for you.',
      'but wait! A third!'
    ]

    $scope.status = isopen: false

    $scope.toggled = (open) ->
      $log.log('Dropdown is now: ', open);

    $scope.toggleDropdown = ($event) ->
      $event.preventDefault();
      $event.stopPropagation();
      $scope.status.isopen = !$scope.status.isopen;
)
