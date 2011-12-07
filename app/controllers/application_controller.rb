class ApplicationController < ActionController::Base
	protect_from_forgery

	# TODO ugly. fix.
	Hound::Crawler.attach_driver(Hound::Driver::LastFM)
	Hound::Crawler.attach_driver(Hound::Driver::SoundCloud)
	Hound::Crawler.attach_driver(Hound::Driver::Youtube)

	def call_rake(task, options = {})
		options[:rails_env] ||= Rails.env
		args = options.map { |n, v| "#{n.to_s.upcase}='#{v}'" }

		if ( is_windows? )
			system "start /B rake #{task} #{args.join(' ')} --trace >> #{Rails.root}/log/rake.log"
		else
			system "/usr/bin/rake #{task} #{args.join(' ')} --trace 2>&1 >> #{Rails.root}/log/rake.log &"
		end
	end

	def is_windows?
		processor, platform, *rest = RUBY_PLATFORM.split("-")
		platform == 'mswin32'
	end

end
