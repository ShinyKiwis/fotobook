class CreatePhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :photos do |t|
      t.string :title
      t.string :description
      t.string :thumbnail_img
      t.integer :like_count
      t.string :sharing_mode
      t.datetime :publication_date
      t.references :user, null: false, foreign_key: true
      t.references :album, null: false, foreign_key: true

      t.timestamps
    end
  end
end
