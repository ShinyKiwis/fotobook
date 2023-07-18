module AdminsHelper
  def generate_title(title)
    truncate(title, length: 20, separator: ' ')
  end
end
