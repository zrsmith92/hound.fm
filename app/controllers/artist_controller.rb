class ArtistController < ApplicationController

  before_filter :find_artist

  def index
    @tracks = @artist.tracks.find(:all, :limit => 10)
  end

  def tracks
    @tracks = @artist.tracks.find(:all)
  end

  def events
  end

  def news
  end

  def photos
  end

  def videos
    @videos = @artist.videos.find(:all)
  end

  def similar
  end

private
  def find_artist
    @artist = Artist.find_by_slug(params[:slug])
    
    redirect_to '/' if @artist.nil?

    if  @artist.hound_status == Hound::STATUS_NEVER_RUN || 
        (@artist.hound_status == Hound::STATUS_IDLE && DateTime.now.in_time_zone - @artist.updated_at > 1.week) ||
        (HoundFm::Application.config.respond_to?(:no_cache) && HoundFm::Application.config.no_cache == true)
      
        Hound::Crawler.go(@artist)
    end
  end

end
