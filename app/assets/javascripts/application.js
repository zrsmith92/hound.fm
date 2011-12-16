// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require ./historyjs/jquery.history.js
//= require_directory .



(function() {
	$.expr[':'].internal = function(obj, index, meta, stack){
		// Prepare
		var $this = $(obj),
			url = $this.attr('href')||'',
			isInternalLink;

		// Check link
		isInternalLink = url.substring(0,Common.rootUrl.length) === Common.rootUrl || url.indexOf(':') === -1;

		// Ignore or Keep
		return isInternalLink;
	};

	$(function() {

		$(window).bind('statechange', Common.stateChange);

		Common.content.delegate('a:internal', 'click', function(event) {
			// Continue as normal for cmd clicks etc
			if ( event.which == 2 || event.metaKey ) { return true; }

			History.pushState(null, null, $(this).attr('href'));

			event.preventDefault();
			return false;
		});
	});

})();