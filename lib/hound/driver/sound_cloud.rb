require 'net/http'

module Hound
	module Driver
		
		class SoundCloud < Base

			BASE_URL = 'http://api.soundcloud.com/'
			CLIENT_ID  = 'O9gqsGuqPcdeRdxeWDQ2g'
			CLIENT_SECRET = 'nWo7XueH8bYX1rgzOZcb3X2WzWk8Pf4RyzCaTFouqNM'

			def self.lookup(a)
				r = self.make_request('users', { :q => a })

				return {} if r.nil?

				ret = {}
				r.each do |a|
					ret[a['username']] = {
						:sound_cloud => {
							:user_id => a['id']
						}
					}
				end

				return ret
			end

			def go
				data = {
					:tracks => []
				}

				unless @artist.hound_meta[:sound_cloud].nil?
					artist_id = @artist.hound_meta[:sound_cloud][:user_id]
				else
					return data
				end
				tracks = self.class.make_request("users/#{ artist_id }/tracks")

				unless tracks.nil?
					tracks.each do |track|
						data[:tracks] << Hound::Media::Track.new({
							:title => track['title'],
							:download_url => track['download_url'] + "?client_id=#{ CLIENT_ID }",
							:stream_url => track['stream_url'] + "?client_id=#{ CLIENT_ID }"
						})
					end
				end

				return data

			end


			def self.make_request(uri, params = {})
				params[:client_id] = CLIENT_ID

				uri = URI(BASE_URL + uri + '.json')
				uri.query = URI.encode_www_form(params)

				res = Net::HTTP.get_response(uri)

				return ActiveSupport::JSON.decode(res.body) if res.is_a?(Net::HTTPSuccess)
				return nil
			end



		end

	end
end