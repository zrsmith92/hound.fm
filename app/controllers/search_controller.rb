class SearchController < ApplicationController

  def index

  	unless params[:q].nil?
  		artist = Artist.find_by_name(params[:q]);
  		
  		if artist.is_a? Artist
  			redirect_to "/artist/#{ artist.slug }" and return
  		else
  			@choices = artist
        handle_ajax({:choices => @choices}, { :action => 'choose' })
  		end
  	end

    handle_ajax

  end

end
