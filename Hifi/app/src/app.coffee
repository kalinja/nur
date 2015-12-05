dependencies = [
  'ngRoute',
  'ngTagsInput',
  'ui.bootstrap',
  'Selftest.filters',
  'Selftest.services',
  'Selftest.controllers',
  'Selftest.directives',
  'Selftest.common',
  'Selftest.routeConfig'
]

app = angular.module('Selftest', dependencies)

angular.module('Selftest.routeConfig', ['ngRoute'])
.config ($routeProvider) ->
  $routeProvider
  .when('/testList', {
      templateUrl: '/app/src/view/testList.html'
    }).when('/testEdit', {
      templateUrl: '/app/src/view/testEdit.html'
    }).when('/testEdit:currentTest', {
      templateUrl: '/app/src/view/testEdit.html'
    }).when('/testPage', {
      templateUrl: '/app/src/view/testPage.html'
    }).when('/testResult', {
      templateUrl: '/app/src/view/testResult.html'
    }).when('/', {
      templateUrl: '/app/src/view/testList.html'
    }).when('/myTests', {
      templateUrl: '/app/src/view/myTests.html'
    }).when('/history', {
      templateUrl: '/app/src/view/history.html'
    })
# .when('/category/:currentCategory', {
#      templateUrl: '/assets/partials/categories.html'
# })
  .otherwise({redirectTo: '/'})
.config ($locationProvider) ->
  $locationProvider.html5Mode({
    enabled: false,
    requireBase: false
  })

@commonModule = angular.module('Selftest.common', [])
@controllersModule = angular.module('Selftest.controllers', [])
@servicesModule = angular.module('Selftest.services', [])
@modelsModule = angular.module('Selftest.models', [])
@directivesModule = angular.module('Selftest.directives', [])
@filtersModule = angular.module('Selftest.filters', [])
