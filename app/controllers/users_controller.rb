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
end
