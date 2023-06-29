class ChangeColumnsDetailsOfPhotos < ActiveRecord::Migration[7.0]
  def change
    change_column_default :photos, :like_count, 0
    change_column_default :photos, :sharing_mode, "public"
  end
end
