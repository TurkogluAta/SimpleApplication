var assert = require('assert');
var app = require('../app');

// Basic smoke tests for the Express app
describe('App', function () {
  it('should be defined', function () {
    assert.ok(app);
  });

  it('should have a handler function', function () {
    assert.strictEqual(typeof app, 'function');
  });
});

// Tests for the index route handler
describe('Index Route', function () {
  it('should render with correct title', function () {
    // Mock res object to capture render call
    var rendered = {};
    var req = {};
    var res = {
      render: function (view, data) {
        rendered.view = view;
        rendered.data = data;
      }
    };

    var router = require('../routes/index');
    // Get the registered GET / handler and call it directly
    var layer = router.stack.find(function (l) {
      return l.route && l.route.path === '/';
    });

    layer.route.stack[0].handle(req, res, function () {});

    assert.strictEqual(rendered.view, 'index');
    assert.strictEqual(rendered.data.title, 'Simple Application');
  });
});
