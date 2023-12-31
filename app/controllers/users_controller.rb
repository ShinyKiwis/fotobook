class UsersController < ApplicationController
  def index
    
  end

  def new
    
  end

  def edit
    
  end

  def show
    
  end

  def password_reset
  end

  def reset_password
  end

  def update
    user = User.find(params[:id])
    user.avatar_img = params[:user][:avatar_img]
    if user.save
      redirect_to edit_user_registration_path
    else
      puts "There is error"
    end
  end

  def following_index
    @user = User.find(params[:user_id])
    @followees = @user.followees.page(params[:page])
    render 'users/following'
  end

  def follower_index
    @user = User.find(params[:user_id])
    @followers = @user.followers.page(params[:page])
    render 'users/follower'
  end

  def follow
    current_user&.follow(params[:id])
  end
end
