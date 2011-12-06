class SearchController < ApplicationController
  def index

  	unless params[:q].nil?
  		artist = Artist.find_by_name(params[:q]);
  		
  		if artist.is_a? Artist
  			redirect_to "/artist/#{ artist.slug }"
  		else
  			@choices = artist
        render 'search/choose'
  		end
  	end

  end

end
