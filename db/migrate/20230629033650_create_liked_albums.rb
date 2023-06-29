class CreateLikedAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :liked_albums do |t|
      t.references :user, null: false, foreign_key: true
      t.references :album, null: false, foreign_key: true

      t.timestamps
    end
  end
end
