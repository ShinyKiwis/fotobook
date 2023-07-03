class ApplicationController < ActionController::Base
  def welcome
    redirect_to feeds_photos_url
  end
end
