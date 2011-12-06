class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.text :bio
      t.string :genre
      t.string :hometown
      t.integer :hound_status

      t.timestamps
    end
  end
end
