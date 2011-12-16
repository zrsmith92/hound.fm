(function($) {
	
	Router.routes.push({
		
		rgx: /(^\/?$|\/search)/,

		load: function() {
			var $searchForm = $('#search-form');
						
			$searchForm.submit(function() {
				

				Common.startStateLoad();

				$.ajax({
					method: 'GET',
					data: $searchForm.serialize(),
					url: '/search',
					dataType: 'json',

					success: Common.endStateLoad
				});

				return false;
			});
		}

	});

})(jQuery);