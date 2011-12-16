module Hound

	class Util
	
		def self.clean_text(t, artist)

			# Followed by anything but an apostrophe so that Jungle Fictions's ... doesn't turn into 's...'
			t.gsub(/[\(\[\{]*#{ artist.name }[\)\]\}]*\s*[-_:]*[^\']/, '')

		end

	end

end