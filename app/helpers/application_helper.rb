module ApplicationHelper

	def get_title(artist, params)
		
		if artist.nil?
			'Hound.FM - Find information about any music artist.'
		elsif params[:action] == 'index'
			"Hound.FM | #{ artist.name }"
		else
			"Hound.FM | #{ artist.name } | #{ params[:action] }"
		end

	end

	def body_classes(params)

		"#{ params[:controller] } #{ params[:action] }"

	end

end
