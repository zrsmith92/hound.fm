(function($, undefined) {

	var selectedTrack = null,
		$musicPlayer,
		$playerTracks,
		$jPlayer,
		$marquee,
		$videoModal,
		
		togglePlayBtns = function() {
			$('.play-btn').removeClass('play-btn').addClass('pause-btn');
		},

		togglePauseBtns = function() {
			$('.pause-btn').removeClass('pause-btn').addClass('play-btn');
		};

	Router.routes.push({
		rgx: /^\/artist\/[a-zA-Z0-9_]+/,
		
		load: function() {
			$jPlayer = $("#j-player");
			$marquee = Common.content.find('.current-track');
			$playerTracks = $("#tracks-list");

			$jPlayer.jPlayer({
				swfPath: "/Jplayer.swf",
				play: togglePlayBtns,
				pause: togglePauseBtns
			});

		}

	});

	// /artist/Jungle_Fiction
	Router.routes.push({
		rgx: /^\/artist\/[a-zA-Z0-9_]+\/?(index)?$/,

		load: function() {
			$playerTracks.delegate('li a', 'click', function() {
				var $this = $(this);

				$playerTracks.find('li').removeClass('active');
				$this.parent().addClass('active');

				$jPlayer.jPlayer('setMedia', { mp3: $this.attr('href') });
				$jPlayer.jPlayer('play');

				$marquee.text($this.attr('title'));

				selectedTrack = $this.parent().index($playerTracks.find('li'));

				return false;
			});			
		}
	});


	// /artist/Jungle_Fiction OR /artist/Jungle_Fiction/tracks
	Router.routes.push({
		rgx: /^\/artist\/[a-zA-Z0-9_]+\/?(index|artist)?$/,
		load: function() {
			Common.body.delegate('.play-btn', 'click', function() {
				if ( selectedTrack === null ) {
					$playerTracks.find('li:first-child a, tr:first-child').click();
					return false;
				}
				$jPlayer.jPlayer('play');
				return false
			}).delegate('.pause-btn', 'click', function() {
				$jPlayer.jPlayer('pause');
				return false;
			}).delegate('.next-btn', 'click', function() {
				if ( selectedTrack === null ) {
					$playerTracks.find('li:first-child a, tbody tr:first-child').click();
					return false;
				}
				var i = (selectedTrack + 1) % $playerTracks.find('tbody tr, li').length;

				$playerTracks.find('tbody tr, li').eq(i).click();
				return false;
			}).delegate('.prev-btn', 'click', function() {
				if ( selectedTrack === null ) {
					$playerTracks.find('li:first-child a, tbody tr:first-child').click();
					return false;
				}

				var i = (selectedTrack - 1) % $playerTracks.find('tbody tr, li').length
				$playerTracks.find('tbody tr, li').eq(i).click();
				return false;

			}).delegate('.video-grid li a', 'click', function() {
				var $this = $(this),
					embedUrl = $this.attr('data-embed-url');

				if ( embedUrl ) {
					
					swfobject.embedSWF(embedUrl, 'video-content', '530', '298', '11', undefined, undefined, { allowFullScreen: true });

					$videoModal.find('.modal-header h3').text($this.find('.video-title').text());
					$videoModal.modal('show');

					return false;
				}
			});

		}
	})

	// /artist/Jungle_Ficion/tracks
	Router.routes.push({
		rgx: /^\/artist\/[a-zA-Z0-9_]+\/tracks/,

		load: function() {
			console.log('/^\/artist\/[a-zA-Z0-9_]+\/tracks/');
			$playerTracks.delegate('tbody tr', 'click', function() {
				var $this = $(this);

				$playerTracks.find('tr').removeClass('active');
				$this.addClass('active');

				$jPlayer.jPlayer('setMedia', { mp3: $this.attr('data-stream-url') });
				$jPlayer.jPlayer('play');

				$marquee.text($this.find('td:first-child').text());

				selectedTrack = $this.index();
			});
		}
	})

	// /artist/Jungle_Ficion/videos
	Router.routes.push({
		rgx: /^\/artist\/[a-zA-Z0-9_]+\/videos/,
		load: function() {
			console.log('/^\/artist\/[a-zA-Z0-9_]+\/tracks/');
			$videoModal = $('<div id="video-player" class="modal"><div class="modal-header"><a class="close" href="#">×</a><h3></h3></div><div class="modal-body"><div id="video-content"></div></div></div>')
				.appendTo(document.body)
				.modal({
					keyboard: true,
					backdrop: true
				});

			$('.video-grid li a').attr('href', '#');
		}
	});

})(jQuery);



// $(function() {
// 	var selectedTrack = null,
// 		$musicPlayer = $('#music-player'),
// 		$playerTracks = $("#tracks-list"),
// 		$jPlayer = $("#j-player"),
// 		$marquee = $('.current-track'),
// 		$videoModal = $('<div id="video-player" class="modal"><div class="modal-header"><a class="close" href="#">×</a><h3></h3></div><div class="modal-body"><div id="video-content"></div></div></div>')
// 			.appendTo(document.body)
// 			.modal({
// 				keyboard: true,
// 				backdrop: true
// 			}),

// 		togglePlayBtns = function() {
// 			$('.play-btn').removeClass('play-btn').addClass('pause-btn')
// 		},

// 		togglePauseBtns = function() {
// 			$('.pause-btn').removeClass('pause-btn').addClass('play-btn')
// 		};

// 	$jPlayer.jPlayer({
// 		swfPath: "/Jplayer.swf",
// 		play: togglePlayBtns,
// 		pause: togglePauseBtns
// 	});

// 	$playerTracks.delegate('li a', 'click', function() {
// 		var $this = $(this);

// 		$playerTracks.find('li').removeClass('active');
// 		$this.parent().addClass('active');

// 		$jPlayer.jPlayer('setMedia', { mp3: $this.attr('href') });
// 		$jPlayer.jPlayer('play');

// 		$marquee.text($this.attr('title'));

// 		selectedTrack = $this.parent().index($playerTracks.find('li'));

// 		return false;
// 	}).delegate('tbody tr', 'click', function() {
// 		var $this = $(this);

// 		$playerTracks.find('tr').removeClass('active');
// 		$this.addClass('active');

// 		$jPlayer.jPlayer('setMedia', { mp3: $this.attr('data-stream-url') });
// 		$jPlayer.jPlayer('play');

// 		$marquee.text($this.find('td:first-child').text());

// 		selectedTrack = $this.index();
// 	});

// 	$('.video-grid li a').attr('href', '#');

// 	$(document.body).delegate('.play-btn', 'click', function() {
// 		if ( selectedTrack === null ) {
// 			$playerTracks.find('li:first-child a, tr:first-child').click();
// 			return false;
// 		}
// 		$jPlayer.jPlayer('play');
// 		return false
// 	}).delegate('.pause-btn', 'click', function() {
// 		$jPlayer.jPlayer('pause');
// 		return false;
// 	}).delegate('.next-btn', 'click', function() {
// 		if ( selectedTrack === null ) {
// 			$playerTracks.find('li:first-child a, tbody tr:first-child').click();
// 			return false;
// 		}
// 		var i = (selectedTrack + 1) % $playerTracks.find('tbody tr, li').length;

// 		$playerTracks.find('tbody tr, li').eq(i).click();
// 		return false;
// 	}).delegate('.prev-btn', 'click', function() {
// 		if ( selectedTrack === null ) {
// 			$playerTracks.find('li:first-child a, tbody tr:first-child').click();
// 			return false;
// 		}

// 		var i = (selectedTrack - 1) % $playerTracks.find('tbody tr, li').length
// 		$playerTracks.find('tbody tr, li').eq(i).click();
// 		return false;

// 	}).delegate('.video-grid li a', 'click', function() {
// 		var $this = $(this),
// 			embedUrl = $this.attr('data-embed-url');

// 		if ( embedUrl ) {
			
// 			swfobject.embedSWF(embedUrl, 'video-content', '530', '298', '11', undefined, undefined, { allowFullScreen: true });

// 			$videoModal.find('.modal-header h3').text($this.find('.video-title').text());
// 			$videoModal.modal('show');

// 			return false;
// 		}
// 	});

// });