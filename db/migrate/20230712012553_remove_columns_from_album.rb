class RemoveColumnsFromAlbum < ActiveRecord::Migration[7.0]
  def change
    remove_column :albums, :thumbnail_img, :string
  end
end
