'use strict';

angular.module('Selftest.version', [
  'Selftest.version.interpolate-filter',
  'Selftest.version.version-directive'
])

.value('version', '0.1');
