module Hound
	module Media	
		class Concert
			attr_accessor :title, :date, :description, :tickets_url

			def initialize(opts={})

				@title = opts[:title]
				@date = opts[:date].is_a?(String) ? DateTime.parse(opts[:date]) : opts[:date]
				@description = opts[:description]
				@tickets_url = opts[:tickets_url]

			end

			def ==(obj)
				return	(obj[:title] == @title ||
						obj[:title].downcase - @title.downcase < Hound::MIN_DIFFERENCE) &&
						obj[:date] == @date
			end
		end
	end
end