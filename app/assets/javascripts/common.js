var Common = (function() {
	
	var $body = $(document.body),
		$loading = $('<div id="loading"/>').appendTo($body).hide(),
		$content = $('#content'),
		$title = $('title:first');
		
		show = function($el) {
			$el.stop().css({ opacity: 0 }).show().animate({ opacity: 1 });
		},

		hide = function($el) {
			$el.stop().css({ opacity: 1 }).animate({ opacity: 0 }, function() { $loading.hide() });
		},

		showLoading = function() {
			show($loading);
		},

		hideLoading = function() {
			hide($loading);
		},

		startStateLoad = function() {
			showLoading();
			hide($content);
			Router.route('unload');
		},

		endStateLoad = function(data) {

			$title.text(data.title);
			$body.attr('class', data.body_classes);

			show($content.html(data.html));
			hideLoading();

			Router.route('load');
		},

		stateChange = function() {
			var state = History.getState(),
				url = state.url;

			startStateLoad();
			$.ajax({
				method: 'GET',
				url: url,
				dataType: 'json',

				success: endStateLoad
			});

		};

	return {
		content: $content,
		body: $body,
		rootUrl: History.getRootUrl(),

		showLoading: showLoading,
		hideLoading: hideLoading,
		startStateLoad: startStateLoad,
		endStateLoad: endStateLoad,
		stateChange: stateChange
	}

})();