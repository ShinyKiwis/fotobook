require 'pry'

class AlbumsController < ApplicationController
  def index
    if request.path.include?("feeds") || request.path.include?("discover")
      @albums = []
      Album.where(sharing_mode: 'public').find_in_batches(batch_size: 20) do |photos|
        @albums.concat(photos)
        break if @albums.size >= 20
      end
      render 'public'
    else
      @albums = []
      if current_user
        @user = params[:user_id] == current_user.id ? current_user : User.find(params[:user_id])
        if @user.id == current_user.id
          @albums.concat(@user.albums)
        else
          @albums = Album.where(user_id: @user.id, sharing_mode: 'public')
        end
      else
        # Guest
        @user = User.find(params[:user_id])
        @albums = Album.where(user_id: @user.id, sharing_mode: 'public')
      end

      render 'personal'
    end
  end

  def create
    album = current_user.albums.build(album_params)
    if album.save
      redirect_to user_albums_path(current_user)
      flash[:notice] = 'Album created successfully'
    else
      puts "ERROR"
    end
  end

  def edit
    @album = Album.find(params[:id])
    @album_photos_urls = @album.photos.map {|photo| photo.url}
  end

  def update
    @album = Album.find(params[:id])
    if params[:save].present?
      @album.update(album_params)
      flash[:notice] = 'Album updated successfully'
    elsif params[:delete].present?
      @album.destroy
      flash[:notice] = 'Album deleted successfully'
    end
    redirect_to user_albums_path(current_user)
  end

  private
  def album_params
    params.require(:album).permit(:title, :description, :sharing_mode, { photos: [] })
  end
end
