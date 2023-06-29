class ChangeColumnsDetailsOfAlbums < ActiveRecord::Migration[7.0]
  def change
    change_column_default :albums, :like_count, 0
    change_column_default :albums, :sharing_mode, "public"
  end
end
