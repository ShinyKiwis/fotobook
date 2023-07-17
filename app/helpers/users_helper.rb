module UsersHelper
  def get_username(user)
    "#{user.first_name} #{user.last_name}"
  end

  def get_short_username(user)
    "#{user.first_name[0].upcase}#{user.last_name[0].upcase}"
  end

  def get_type_link(type, user_id)
    case type.downcase
    when 'photos'
      user_photos_path(user_id)
    when 'albums'
      user_albums_path(user_id)
    when 'followings'
      user_followings_path(user_id)
    when 'followers'
      user_followers_path(user_id)
    end
  end
end
