class Video < ActiveRecord::Base
  belongs_to :artist

  serialize :hound_meta
end
