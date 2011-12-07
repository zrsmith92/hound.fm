class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :embed_html
      t.string :download_url
      t.string :thumb_url
      t.string :src_url
      t.references :artist
      t.text :hound_meta

      t.timestamps
    end
    add_index :videos, :artist_id
  end
end
