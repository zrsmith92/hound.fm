$(function() {
	var selectedTrack = null,
		$musicPlayer = $('#music-player'),
		$playerTracks = $("#tracks-list"),
		$jPlayer = $("#j-player"),
		$marquee = $('.current-track'),
		togglePlayBtns = function() {
			$('.play-btn').removeClass('play-btn').addClass('pause-btn')
		},

		togglePauseBtns = function() {
			$('.pause-btn').removeClass('pause-btn').addClass('play-btn')
		};

	$jPlayer.jPlayer({
		swfPath: "/Jplayer.swf",
		play: togglePlayBtns,
		pause: togglePauseBtns
	});

	$playerTracks.delegate('li a', 'click', function() {
		var $this = $(this);

		$playerTracks.find('li').removeClass('active');
		$this.parent().addClass('active');

		$jPlayer.jPlayer('setMedia', { mp3: $this.attr('href') });
		$jPlayer.jPlayer('play');

		$marquee.text($this.attr('title'));

		selectedTrack = $this.parent().index($playerTracks.find('li'));

		return false;
	}).delegate('tbody tr', 'click', function() {
		var $this = $(this);

		$playerTracks.find('tr').removeClass('active');
		$this.addClass('active');

		$jPlayer.jPlayer('setMedia', { mp3: $this.attr('data-stream-url') });
		$jPlayer.jPlayer('play');

		$marquee.text($this.find('td:first-child').text());

		selectedTrack = $this.index();
	});

	$(document.body).delegate('.play-btn', 'click', function() {
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

	});


})