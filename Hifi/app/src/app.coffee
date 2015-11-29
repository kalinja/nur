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
            .when('/testEdit', {
                templateUrl: '/app/src/view/testEdit.html'
            })
            .when('/testEdit:currentTest', {
                templateUrl: '/app/src/view/testEdit.html'
            })
            # .when('/category/:currentCategory', {
            #      templateUrl: '/assets/partials/categories.html'
            # })
            .otherwise({redirectTo: '/testEdit'})
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
