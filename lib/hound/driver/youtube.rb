require 'net/http'
require 'nokogiri'

module Hound
	module Driver

		class Youtube < Base

			BASE_URL = 'http://gdata.youtube.com/feeds/api/'

			def go

				data = {
					:videos => []
				}

				r = self.class.make_request('videos', { :q => @artist.name, :category => 'Music' })

				r.css('feed entry').each do |entry|
					
					title = entry.css('title').first.text
					embed_html = entry.css('content[type="application/x-shockwave-flash"]').first.attr('src')
					src_url = entry.css('link[rel=alternate]').first.attr('href')
					thumb_url = entry.css('media|group media|thumbnail').first.attr('url')
					download_url = nil

					data[:videos] << Hound::Media::Video.new({
						:title => title,
						:embed_html => embed_html,
						:src_url => src_url,
						:thumb_url => thumb_url,
						:download_url => download_url
					})

				end

				return data

			end

			def self.make_request(method, params={})
				params[:v] = 2

				uri = URI(BASE_URL + method)
				uri.query = URI.encode_www_form(params)

				res = Net::HTTP.get_response(uri)

				return Nokogiri::XML.parse(res.body) if res.is_a?(Net::HTTPSuccess)
				return nil

			end

		end

	end
end