require 'net/http'


module Hound
	module Driver

		class LastFM < Base

			BASE_URL = "http://ws.audioscrobbler.com/2.0/"
			API_KEY = "0b1492583ffbedf5c1a2c9de7310966e"
			API_SECRET = "0b1492583ffbedf5c1a2c9de7310966e"


			def self.lookup(a)
				r = self.make_request('artist.search', {
					:artist => a
				})

				return {} if r.nil? || r['results']['opensearch:totalResults'] == '0'
				ret = {}

				#stupid stupid stupid...
				if r['results']['artistmatches']['artist'].is_a?(Hash)
					artists = [ r['results']['artistmatches']['artist'] ]
				else
					artists = r['results']['artistmatches']['artist']
				end

				artists.each do |a|
					ret[a['name']] = {
						:lastfm => {
							:url => a['url']
						}
					}
				end

				return ret
			end

			def go
				data = {
					:images => [],
					:tracks => []
				}

				r = self.class.make_request('artist.getinfo', {
					:artist => @artist.name
				})

				if r.nil? || r['error']
					return data
				end

				r = r['artist']

				if r['bio']
					data[:bio] = r['bio']['content']
				end

				if r['tags'] && r['tags']['tag']
					tags = r['tags']['tag'].map{|t| t['name'] }
					data[:genre] = tags.join('/')
				end

				if r['image']
					data[:images] << Media::Image.new({
						:full_url => r['image'].last['#text'],
						:thumb_url => r['image'].length >= 2 ? r['image'][-2]['#text'] : nil
					})
				end

				if r['streamable'] == "1"
					t = self.class.make_request('artist.gettoptracks', {
						:artist => @artist.name
					})

					unless t.nil? || r['error']

						t = t['toptracks']['track']

						t.each do |track|

							unless track['downloadurl'].nil?
								data[:tracks] << Hound::Media::Track.new({
									:title => Hound::Util.clean_text(track['name'], @artist),
									:download_url => track['downloadurl'],
									:stream_url => track['streamable']['fulltrack'] == "1" ? track['downloadurl'] : nil
								})
							end

						end

					end
				end

				return data
			end

			def self.make_request(method, params = {})
				params[:method] = method
				params[:api_key] = API_KEY

				if params[:format].nil?
					params[:format] = 'json'
				end

				uri = URI(BASE_URL)
				uri.query = URI.encode_www_form(params)

				res = Net::HTTP.get_response(uri)

				return ActiveSupport::JSON.decode(res.body) if res.is_a?(Net::HTTPSuccess)
				return nil
			end

		end

	end

end