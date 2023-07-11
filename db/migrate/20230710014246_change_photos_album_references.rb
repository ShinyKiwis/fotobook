class ChangePhotosAlbumReferences < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up { change_column_null :photos, :album_id, true}
      dir.down { change_column_null :photos, :album_id, false}
    end
  end
end
