require 'pry'
class AdminsController < ApplicationController
  def index
    if request.path.include?("photos")
      @photos = Photo.all
      render 'photos'
    elsif request.path.include?("albums")
      @albums = Album.all
      render 'albums'
    else
      @users = User.all
      render 'users'
    end
  end

  def delete_user
    user = User.find(params[:user_id])
    user.destroy
    redirect_to request.referrer
  end
end
