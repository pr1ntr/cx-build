// this is just a generic browserify bundle plugin to compile coffee-script

var coffee = require('coffee-script');
var through = require('through');
var convert = require('convert-source-map');

function compile(source_map) {
	function coffee_compile(file) {
		if ( ! /\.coffee$/.test(file)) return through();

		var data = '';

		function write(buf) { 
			data += buf; 
		}

		function end () {
			var js;
			// if we don't set the filename, coffee compile data will come out bare :(

			if (source_map) {
				var compiled = coffee.compile(data, {sourceMap: true, filename: file});
				var comment = convert.fromJSON(compiled.v3SourceMap).setProperty('sourcesContent', [ data ]).toComment();
				js = compiled.js + '\n' + comment;
			}
			else {
				js = coffee.compile(data, {filename: file});
			}

			this.queue(js);
			this.queue(null);
		}

		return through(write, end);
	}
	return coffee_compile;
}

module.exports = compile;

