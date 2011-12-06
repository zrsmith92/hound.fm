module Hound
	module Media
		class Image

			attr_accessor :caption, :thumb_url, :full_url

			def initialize(opts={})

				@caption = opts[:caption]
				@thumb_url = opts[:thumb_url]
				@full_url = opts[:full_url]

			end

			def ==(obj)

				return	obj[:caption] == @caption ||
						(obj[:caption].downcase - @caption.downcase) < MIN_DIFFERENCE ||
						obj[:thumb_url] == @thumb_url ||
						obj[:full_url] == @full_url

			end

		end
	end
end