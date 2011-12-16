class Artist < ActiveRecord::Base

	has_many :images
	has_many :tracks
	has_many :videos

	serialize :hound_meta

	def self.find_by_name(q)

		q.downcase!

		artist = Artist.find(:first, :conditions => [ "lower(name) = ?", q ])

		# return what's already in db
		return artist unless artist.nil?

		# not in our DB. Need to look at API's to find actual artist name
		results = Hound::Crawler.lookup(q)
		
		artists = []
		results.each do |name, meta|

			if name.downcase == q
				# exact match. create artist & return it and we'll go directly to that artist's page
				return Artist.create({
					:name => name, 
					:hound_status => Hound::STATUS_NEVER_RUN,
					:slug => self.create_slug(name),
					:hound_meta => meta
				})
			end

			artists.push(name)
		end
		
		# return list of partial matches for the user to choose from
		return artists

	end

	def self.create_slug(s)
		#strip the string
	    s = s.strip

	    #blow away apostrophes
	    s.gsub! /['`]/,""

	    # @ --> at, and & --> and
	    s.gsub! /\s*@\s*/, " at "
	    s.gsub! /\s*&\s*/, " and "

	    #replace all non alphanumeric, underscore or periods with underscore
	    s.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '_'  

	    #convert double underscores to single
	    s.gsub! /_+/,"_"

	    #strip off leading/trailing underscore
	    s.gsub! /\A[_\.]+|[_\.]+\z/,""

	    if ( Artist.find_by_slug(s).nil? )
			return s
	    else
			if s[-2,2] =~ /^_\d$/
				return self.create_slug(s[0..-2] + (s[-1,1].to_i + 1).to_s)
			else
				return self.create_slug(s + '_1')
			end
	    end
	 end

	 protected
	 def encode_meta
	 	self.hound_meta = ActiveSupport::JSON.encode(self.hound_meta)
	 end

end
