require 'pry'

class AlbumsController < ApplicationController
  def index
    @albums = []
    if request.path.include?('feeds')
      if current_user && request.path.include?('feeds')
        following_users = current_user.followees
        following_users.each do |user|
          @albums = user.albums.where(sharing_mode: 'public').page(params[:page]).per(10)
        end
      end
      render 'public'
    else
      if current_user
        @user = params[:user_id] == current_user.id ? current_user : User.find(params[:user_id])
        if @user.id == current_user.id
          @albums = @user.albums.page(params[:page]).per(20)
        else
          @albums = Album.where(user_id: @user.id, sharing_mode: 'public').page(params[:page]).per(10)
        end
      else
        # Guest
        @user = User.find(params[:user_id])
        @albums = Album.where(user_id: @user.id, sharing_mode: 'public').page(params[:page]).per(10)
      end

      render 'personal'
    end
  end

  def index_discover
    @albums = Album.where(sharing_mode: 'public').order(created_at: :desc).page(params[:page]).per(10)
    render 'public'
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
    if current_user.is_admin
      redirect_to albums_admin_path
    else
      redirect_to user_albums_path(current_user)
    end
  end

  def like
    return nil if current_user.nil?

    @album = Album.find(params[:id])
    current_user.like(@album)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: personal_stream
      end
    end
  end

  private

  def personal_stream
    personal_target = "#{helpers.dom_id(@album)}_personal_likes"
    # binding.pry
    turbo_stream.replace(personal_target,
                         partial: "shared/buttons/like/like_button",
                         locals: {
                           asset: @album,
                           like_status: current_user.liked?(@album)
                         }
                        )
  end
  def album_params
    params.require(:album).permit(:title, :description, :sharing_mode, { photos: [] })
  end
end
