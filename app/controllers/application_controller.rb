class ApplicationController < ActionController::Base
  def welcome
    redirect_to photos_url
  end
end
