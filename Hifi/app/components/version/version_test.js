'use strict';

describe('Selftest.version module', function() {
  beforeEach(module('Selftest.version'));

  describe('version service', function() {
    it('should return current version', inject(function(version) {
      expect(version).toEqual('0.1');
    }));
  });
});
