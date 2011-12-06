class ArtistController < ApplicationController

  before_filter :find_artist

  def index
  end

  def tracks
  end

  def events
  end

  def news
  end

  def photos
  end

  def videos
  end

  def similar
  end

private
  def find_artist
    @artist = Artist.find_by_slug(params[:slug])
    
    redirect_to '/' if @artist.nil?

    if  @artist.hound_status == Hound::STATUS_NEVER_RUN || 
        (@artist.hound_status == Hound::STATUS_IDLE && DateTime.now.in_time_zone - @artist.updated_at > 1.week)
      
        Hound::Crawler.go(@artist)
    end
  end

end
