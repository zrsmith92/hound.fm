module Hound
	module Media
		class Track

			attr_accessor :title, :stream_url, :download_url

			def initialize(opts={})

				@title = opts[:title]
				@stream_url = opts[:stream_url]
				@download_url = opts[:download_url]

			end

			def ==(obj)
				return obj.title.downcase == @title.downcase || obj.title.downcase - @title.downcase < Hound::MIN_DIFFERENCE
			end

		end
	end
end