module Hound
	class Crawler

		def self.attach_driver(driver)

			#if ( driver.kind_of?(Driver) )
				@drivers.push(driver)
			#end
		end

		def self.go(artist)

			artist.hound_status = STATUS_RUNNING
			artist.save

			driver_data = []

			@drivers.each do |d|
				driver_data << d.new(artist).go
			end

			# TODO merge driver_data
			# data = driver_data.first
			data = merge_driver_data(driver_data)

			artist.bio = data[:bio]
			artist.genre = data[:genre]

			artist.images.delete_all
			data[:images].each do |i|
				artist.images << Image.create({
					:caption => i.caption,
					:thumb_url => i.thumb_url,
					:full_url => i.full_url
				})
			end

			artist.tracks.delete_all
			data[:tracks].each do |t|
				artist.tracks << Track.create({
					:title => t.title,
					:stream_url => t.stream_url,
					:download_url => t.download_url
				})
			end

			artist.videos.delete_all
			data[:videos].each do |v|
				artist.videos << Video.create({
					:title => v.title,
					:embed_html => v.embed_html,
					:src_url => v.src_url,
					:download_url => v.download_url,
					:thumb_url => v.thumb_url
				})
			end

			artist.hound_status = STATUS_IDLE
			artist.save
		end

		def self.lookup(artist)
			artists = {}
			@drivers.each do |d|
				artists.merge!(d.lookup(artist)) do |key, oldVal, newVal|
					oldVal.merge(newVal)
				end
			end
			artists
		end

		protected
		@drivers = []


		def self.merge_driver_data(driver_data)
			# TODO - DRY up duplicate find (maybe make small media class w/ compare functions)
			# TODO - Add prioritization for certain sources being better than others.

			data = {
				:bio => nil,
				:genre => nil,
				:tracks => [
=begin
{
	:title,
	:stream_url,
	:download_url
}
=end
				],
				:concerts => [
=begin
{
	:title,
	:date,
	:description,
	:tickets_url
}
=end
				],
				:news => [
=begin
{
	:title,
	:body,
	:date
}
=end
				],
				:images => [
=begin
{
	:caption,
	:thumb_url,
	:full_url
}
=end
				],
				:videos => [
=begin
{
	:title
	:stream_url
}
=end
				]
			}

			driver_data.each do |d|

				unless d[:bio].nil?
					#simple length prioritization
					if data[:bio].nil? || data[:bio].length < d[:bio].length
						data[:bio] = d[:bio]
					end
				end

				if !d[:genre].nil? && data[:genre].nil?
					data[:genre] = d[:genre]
				end

				unless d[:tracks].nil?
					data[:tracks] |= d[:tracks]
				end

				unless d[:concerts].nil?
					data[:concerts] |= d[:concerts]
				end

				unless d[:images].nil?
					data[:images] |= d[:images]
				end

				unless d[:videos].nil?
					data[:videos] |= d[:videos]
				end

				# unless d[:videos].nil?
				# 	d[:videos].each do |video|
				# 		found = false

				# 		data[:videos].each do |data_video|
				# 			if 	data_video[:title] == video[:title] ||
				# 				(data_video[:title].downcase - video[:title].downcase) < MIN_DIFFERENCE ||
				# 				data_video[:stream_url] == video[:stream_url]

				# 				found = true
				# 			end
				# 		end

				# 		unless found
				# 			data[:videos] << video
				# 		end
				# 	end
				# end

			end

			return data
		end

	end
end