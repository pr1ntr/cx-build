var watcher = require('node-watch');
var uglify = require('uglify-js');
var browserify = require('browserify');
var coffee = require('./coffee');

function browserify_express(opts) {
	var bundle, cache_time;
	var cache = '';
	
	if (typeof opts !== 'object') throw new Error('opts must be an object');
	if ( ! opts.entry) throw new Error('must provide an entry point');
	if ( ! opts.mount) throw new Error('must provide a mount point');

	opts.bundle_opts = opts.bundle_opts || {};
  opts.watch_opts = opts.watch_opts || {};
  
	bundle = browserify(opts.entry);
	bundle.transform( coffee(opts.coffee_source_map) );

	function bundle_it() {
		var stime = new Date();
		bundle.bundle(opts.bundle_opts, function(err, src) {
			cache_time = new Date();
			cache = src;

			if (opts.minify) cache = uglify.minify(cache, {fromString: true}).code;
			
			if (opts.verbose) {
				var bundle_seconds = Number(((new Date()) - stime) / 1000);
				console.log('browserify -- bundled [' + bundle_seconds.toFixed(2) + 's] ' + opts.mount);
			}
		});
	}

	bundle_it();

	if (opts.watch) {
		console.log('browserify -- watching ' + opts.watch);
		watcher(opts.watch, opts.watch_opts, bundle_it);	
	}
	
	return function(req, res, next) {
		if (req.url.split('?')[0] === opts.mount) {
			res.statusCode = 200;
			res.setHeader('last-modified', cache_time.toString());
			res.setHeader('content-type', 'text/javascript');
			res.end(cache);
		}
		else {
			next();
		}
	};
}

module.exports = browserify_express;

