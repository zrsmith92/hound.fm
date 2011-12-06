class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :title
      t.string :stream_url
      t.string :download_url
      t.references :artist

      t.timestamps
    end
    add_index :tracks, :artist_id
  end
end
