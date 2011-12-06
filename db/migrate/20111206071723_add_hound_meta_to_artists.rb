class AddHoundMetaToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :hound_meta, :text
  end
end
