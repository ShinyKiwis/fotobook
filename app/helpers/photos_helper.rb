module PhotosHelper
  def get_photo_owner(photo)
    User.find(photo.user_id)
  end
end
