var Router = (function() {
	
	var routes = [],

		route = function(e, url) {
			var i = 0,
				l = this.routes.length,
				url = (typeof url === 'undefined') ? History.getShortUrl(History.getPageUrl()) : url,
				route = null,
				matched = [];
			
			for ( ; i < l; i++ ) {
				route = this.routes[i];
				if ( 
					url.match(route.rgx) !== null &&
					route[e]
				) {
					route[e]();
					matched.push(this.routes[i]);
				}
			}
			return matched;
		};


	return {
		routes: routes,
		route: route
	};

})();


$(function() {
	Router.route('load');
})