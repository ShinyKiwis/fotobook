module UsersHelper
  def get_username(user)
    "#{user.first_name} #{user.last_name}"
  end

  def get_short_username(user)
    "#{user.first_name[0].upcase}#{user.last_name[0].upcase}"
  end

end
