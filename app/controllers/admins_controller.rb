require 'pry'
class AdminsController < ApplicationController
  before_action :authorize_user
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

  def show
    @user = User.find(params[:id])
    render 'edit_user'
  end

  def update
    user = User.find(params[:id])
    user.update(update_user_param)
  end

  def delete_user
    user = User.find(params[:user_id])
    user.destroy
    redirect_to request.referrer
  end

  private
  def update_user_param
    params.require(:user).permit(:first_name, :last_name, :email, :is_active, :password)
  end

  def authorize_user
    if !current_user&.is_admin
      flash[:alert] = 'Unauthorized User'
      redirect_to root_path
    end
  end
end
