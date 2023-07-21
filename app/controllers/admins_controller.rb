require 'pry'
class AdminsController < ApplicationController
  before_action :authorize_user
  def index
    @photos = Photo.page(params[:page])
    render 'photos'
  end

  def index_albums
    @albums = Album.page(params[:page])
    render 'albums'
  end

  def index_users
    @users = User.page(params[:page])
    render 'users'
  end

  def show
    @user = User.find(params[:id])
    render 'edit_user'
  end

  def update
    user = User.find(params[:id])
    if !params[:user][:password].empty?
      puts "HERE"
      user.update(update_user_params)
    else
      puts "THERE"
      user.update(update_user_params_without_password)
    end
    if user.errors.empty?
      flash[:notice] = 'Update successfully'
      redirect_to users_admin_path
    else
      flash[:alert] = user.errors.full_messages
    end
  end

  def delete_user
    user = User.find(params[:user_id])
    user.destroy
    redirect_to request.referrer
  end

  private
  def update_user_params
    params.require(:user).permit(:first_name, :last_name, :email, :is_active, :password)
  end
  
  def update_user_params_without_password
    params.require(:user).permit(:first_name, :last_name, :email, :is_active)
  end

  def authorize_user
    if !current_user&.is_admin
      flash[:alert] = 'Unauthorized User'
      redirect_to root_path
    end
  end
end
