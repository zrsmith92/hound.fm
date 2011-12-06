class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :caption
      t.string :thumb_url
      t.string :full_url
      t.references :artist

      t.timestamps
    end
  end
end
