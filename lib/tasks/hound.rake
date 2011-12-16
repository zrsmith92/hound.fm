namespace :hound do

	desc 'Runs the Hound crawler for the artist whose id is passed'
	task 'go' => ['environment'] do |t, args|
		#artist = Artist.find()
		puts args[:artist_id]
		#Hound::Crawler.go(artist)
	end

end