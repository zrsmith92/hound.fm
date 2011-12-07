module Hound
	module Media
		class Video

			attr_accessor :title, :embed_html, :src_url, :download_url, :thumb_url

			def initialize(opts={})

				@title = opts[:title]
				@embed_html = opts[:embed_html]
				@src_url = opts[:src_url]
				@download_url = opts[:download_url]
				@thumb_url = opts[:thumb_url]
				@hound_meta = opts[:hound_meta]

			end

			def ==(obj)
				return obj.title.downcase == @title.downcase || obj.title.downcase - @title.downcase < Hound::MIN_DIFFERENCE ||
					obj.src_url == @src_url || obj.embed_html == @embed_html
			end


		end
	end
end