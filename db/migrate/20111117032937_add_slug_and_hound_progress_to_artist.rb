class AddSlugAndHoundProgressToArtist < ActiveRecord::Migration
  def change
    add_column :artists, :slug, :string
    add_column :artists, :hound_progress, :float
  end
end
