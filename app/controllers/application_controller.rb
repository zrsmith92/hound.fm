class ApplicationController < ActionController::Base
	protect_from_forgery
	include ApplicationHelper


	# TODO ugly. fix.
	Hound::Crawler.attach_driver(Hound::Driver::LastFM)
	Hound::Crawler.attach_driver(Hound::Driver::SoundCloud)
	Hound::Crawler.attach_driver(Hound::Driver::Youtube)

	def call_rake(task, options = {})
		options[:rails_env] ||= Rails.env
		args = options.map { |n, v| "#{ n.to_s.upcase }='#{v}'" }

		system "/usr/bin/rake #{task} #{ args.join(' ') } --trace 2>&1 >> #{Rails.root}/log/rake.log &"
	end

	def handle_ajax(data = {}, render_opts = {})

		respond_to do |format|

			format.html
			format.json do
				self.formats = ["html"]

				render_opts[:layout] = false

				data[:artist] = @artist if instance_variables.include?(:@artist)
				data[:url] = request.path
				data[:title] = get_title(@artist, params)
				data[:body_classes] = body_classes(params)
				data[:html] = render_to_string(render_opts)

				render :json => data
			end

		end

	end


end
