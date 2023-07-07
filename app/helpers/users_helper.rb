module UsersHelper
  def get_username
    "#{current_user.first_name} #{current_user.last_name}"
  end

  def get_short_username
    "#{current_user.first_name[0].upcase}#{current_user.last_name[0].upcase}"
  end
end
