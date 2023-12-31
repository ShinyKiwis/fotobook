require 'pry'

class PhotosController < ApplicationController
  def index
    @photos = []
    if request.path.include?('feeds') || request.path == root_path
      if current_user && request.path.include?('feeds')
        following_users = current_user.followees
        @photos = Photo.order(created_at: :desc).where(sharing_mode: 'public', user_id: following_users.pluck(:id)).page(params[:page]).per(10)
        # binding.pry
        # following_users.each do |user|
        #   @photos = user.photos.where(sharing_mode: 'public').page(params[:page]).per(10)
        # end
      end
        # binding.pry
      render 'public'
    else
      if current_user
        @user = params[:user_id] == current_user.id ? current_user : User.find(params[:user_id])
        if @user.id == current_user.id
          @photos = @user.photos.page(params[:page]).per(20)
        else
          @photos = Photo.where(user_id: @user.id, sharing_mode: 'public').page(params[:page]).per(20)
        end
      else
        @user = User.find(params[:user_id])
        @photos = Photo.where(user_id: @user.id, sharing_mode: 'public').page(params[:page]).per(20)
      end
      render 'personal'
    end
  end

  def index_discover
    @photos = Photo.where(sharing_mode: 'public').order(created_at: :desc).page(params[:page]).per(10)
    render 'public'
  end

  def create
    photo = current_user.photos.build(photo_params)
    photo.thumbnail_img = params[:thumbnail_img]
    if photo.save
      flash[:notice] = 'Photo created successfully'
      redirect_to user_photos_path(current_user)
    else
      puts "ERROR"
    end
  end

  def new
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if params[:save].present?
      @photo.update(photo_params)
      flash[:notice] = 'Photo updated successfully'
    elsif params[:delete].present?
      @photo.destroy
      flash[:notice] = 'Photo deleted successfully'
    end
    if current_user.is_admin
      redirect_to photos_admin_path
    else
      redirect_to user_photos_path(current_user)
    end
  end

  def like
    return nil if current_user.nil?

    @photo = Photo.find(params[:id])
    current_user.like(@photo)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: personal_stream
      end
    end
  end

  private

  def personal_stream
    personal_target = "#{helpers.dom_id(@photo)}_personal_likes"
    # binding.pry
    turbo_stream.replace(personal_target,
                         partial: "shared/buttons/like/like_button",
                         locals: {
                           asset: @photo,
                           like_status: current_user.liked?(@photo)
                         }
                        )
  end

  def photo_params
    params.require(:photo).permit(:title, :description, :thumbnail_img, :sharing_mode)
  end
end
