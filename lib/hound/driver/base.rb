module Hound
	module Driver
		class Base

			def initialize(a)
				@artist = a
			end

			def go
				{}
			end

			def self.lookup(a)
				{}
			end

		end
	end
end