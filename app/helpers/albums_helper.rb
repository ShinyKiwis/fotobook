module AlbumsHelper
  def get_album_owner(album)
    User.find(album.user_id)
  end
end
