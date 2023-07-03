module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Fotobook'
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def path(page_title, type, obj)
    if page_title.include?('feeds') 
      type.downcase == 'photo' ? feeds_photos_path(obj) : feeds_albums_path(obj)
    else
      type.downcase == 'photo' ? discover_photos_path(obj) : discover_albums_path(obj)
    end
  end
end
